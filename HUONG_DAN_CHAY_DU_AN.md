# Hướng dẫn chạy dự án Ngọc Rồng Online (SOURCETEAMOBI2026)

> Tài liệu này được viết dựa trên việc đọc source, config, jar và file SQL trong thư mục dự án.
> Các bước chưa được chạy thử trên máy thật. Những chỗ chưa xác định được sẽ ghi rõ ở mục **Lưu ý / Chưa xác định**.

---

## 1. Tổng quan

### 1.1. Dự án gồm những gì

| Thành phần | Đường dẫn | Vai trò |
|---|---|---|
| Server game (Java) | `SRC/` | Xử lý toàn bộ logic game, mở socket cho client kết nối (mặc định cổng `14445`) |
| Bản server đã build | `SRC/20.jar` | Bản chạy thật (fat jar, đã gói sẵn thư viện). `run.bat` gọi file này |
| Database dump | `database team2026.sql` | Dữ liệu game (41 bảng, tên DB `team2026`) |
| Client game (Unity) | `LÂU CỒ MOD/XUNGLORDLOCAL.exe` | Client cho người chơi, **chỉ chạy trên Windows** |
| Tài liệu phụ | `item.xlsx`, `Lệnh admin.docx` | Bảng item và danh sách lệnh admin |

### 1.2. Kiến trúc chạy

```
 Client Unity (Windows)  ──TCP 14445──►  Server Java (20.jar)  ──JDBC──►  MySQL/MariaDB (team2026)
                                              │
                                              └── đọc file tĩnh trong SRC/data/ (map, mob, effect, ảnh...)
```

- Entry point: `nro.models.server.ServerManager` (có trong manifest của `20.jar`).
- Server đọc `Config.properties` và thư mục `data/` theo **đường dẫn tương đối**, nên **phải chạy lệnh từ bên trong thư mục `SRC/`**.
- Kết nối DB qua HikariCP, driver `mysql-connector-java 5.1.23` (bản cũ, xem mục 4.2 về tương thích).

### 1.3. Yêu cầu hệ thống

| Thành phần | Yêu cầu |
|---|---|
| Java | **JDK/JRE 17 trở lên** (class biên dịch ở Java 17, `javac.source=17`) |
| Database | MariaDB 10.4+ hoặc MySQL 5.7 (dump được xuất từ MariaDB 10.4.32). Xem lưu ý MySQL 8 ở mục 4.2 |
| RAM | Tối thiểu khoảng 1–2 GB cho JVM (cấu hình mặc định cho phép tối đa 1000 người chơi) |
| Client | Windows 64-bit (file `.exe` là PE32+ x86-64). Trên macOS/Linux cần Wine hoặc máy ảo Windows |
| Cổng mạng | `14445/TCP` (game), `3306/TCP` (DB, chỉ cần mở nội bộ) |

---

## 2. Cách kiểm tra trước từng bước

Mỗi bước ở mục 3 đều bắt đầu bằng khối **Kiểm tra trước khi làm**. Có hai cách dùng:

- **Dùng script** (chỉ đọc, không cài, không sửa, không xoá gì). Thay `N` bằng số bước:
  ```bash
  cd ~/Documents/Games/SOURCETEAMOBI2026
  bash kiem_tra_truoc_khi_cai.sh N      # ví dụ: bash kiem_tra_truoc_khi_cai.sh 3
  bash kiem_tra_truoc_khi_cai.sh        # không có N: kiểm tra lần lượt Bước 1 đến 9
  ```
- **Tự kiểm tra bằng tay**: copy các lệnh trong khối kiểm tra của bước đó và so với kết quả mong đợi.

Nhãn của script:

| Nhãn | Ý nghĩa |
|---|---|
| `[ OK ]` | Đạt |
| `[CHÚ Ý]` | Chưa chắc là lỗi nhưng nên đọc. Thường vẫn làm tiếp được |
| `[LỖI]` | Phải sửa trước khi làm bước này. Script thoát với mã `1` |

Quy tắc: **chưa hết `[LỖI]` thì chưa làm bước đó.** Ngoài ra, nếu khối kiểm tra cho thấy bước đã xong (ví dụ Java đã đủ, container DB đã chạy, DB đã import) thì có thể bỏ qua bước.

---

## 3. Các bước cài đặt

Các lệnh bên dưới viết cho macOS/Linux. Trên Windows dùng `run.bat` thay cho lệnh `java -jar`.

### Bước 1. Cài Java 17+

**Kiểm tra trước khi làm** (`bash kiem_tra_truoc_khi_cai.sh 1`)

```bash
java -version      # đã in "17" trở lên thì BỎ QUA bước này
command -v brew    # phải in ra đường dẫn, nếu không thì chưa có Homebrew
```

```bash
# macOS (Homebrew)
brew install openjdk@17
java -version        # phải hiển thị 17 trở lên
```

Windows: tải JDK 17+ (ví dụ Temurin) rồi kiểm tra `java -version`.

### Bước 2. Cài và khởi động database

**Kiểm tra trước khi làm** (`bash kiem_tra_truoc_khi_cai.sh 2`)

```bash
docker info > /dev/null 2>&1 && echo "Docker chạy" || echo "Docker CHƯA chạy"   # cần "Docker chạy"
docker ps -a --format '{{.Names}}' | grep -x nro-mariadb                          # có in ra: container đã tồn tại, đừng docker run lại
lsof -nP -iTCP:3307 -sTCP:LISTEN                                                  # không in gì = cổng 3307 còn trống
brew list --versions mysql                                                        # có in ra: KHÔNG dùng Cách B (brew install mariadb)
```

- Nếu container `nro-mariadb` đã có nhưng đang dừng: chạy `docker start nro-mariadb`, **không** chạy lại `docker run`.
- Cổng `3307` bị chiếm: đổi số đầu của `-p 3307:3306` sang cổng khác và nhớ sửa `database.port` ở Bước 4.

Chọn một trong các cách sau.

**Cách A. Docker (khuyến nghị trên Mac, đặc biệt khi máy đã có MySQL của Homebrew).** Cần mở Docker Desktop trước. Dùng cổng `3307` để không đụng MySQL có sẵn:

```bash
docker run -d --name nro-mariadb \
  -e MARIADB_ROOT_PASSWORD=nro123 \
  -e MARIADB_DATABASE=team2026 \
  -p 3307:3306 -v nro-db:/var/lib/mysql \
  mariadb:10.6 --character-set-server=utf8mb4 --collation-server=utf8mb4_general_ci
```

Đợi khoảng 15 giây cho DB khởi động.

> **Phải dùng `mariadb:10.6`, không dùng bản mới hơn.** MariaDB từ 10.10 trở lên có 184 collation `uca1400_*` với ID rỗng. Driver `mysql-connector-java 5.1.23` của dự án đọc chúng vào `TreeMap` và gặp `NullPointerException` ở `buildCollationMapping`, khiến server không nối được DB. Không hạ phiên bản trên volume cũ được: nếu đã tạo bằng bản mới thì phải `docker rm -f nro-mariadb && docker volume rm nro-db` rồi tạo lại.

**Cách B. MariaDB bằng Homebrew.** Chỉ dùng khi máy **chưa** có MySQL của Homebrew:

```bash
brew install mariadb
brew services start mariadb
```

**Cách C.** XAMPP trên Windows (MariaDB đi kèm).

> Không dùng MySQL 8/9 với driver `5.1.23` của dự án. Xem mục 4.2.

### Bước 3. Tạo database và import dữ liệu

**Kiểm tra trước khi làm** (`bash kiem_tra_truoc_khi_cai.sh 3`)

```bash
cd ~/Documents/Games/SOURCETEAMOBI2026
ls -la "database team2026.sql"                                  # phải có file (khoảng 1 MB)
docker ps --filter name=nro-mariadb --format '{{.Status}}'      # phải in "Up ..."
docker exec nro-mariadb mariadb -uroot -pnro123 -N -e \
  "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='team2026'"
```

Đọc kết quả của lệnh cuối:

| Kết quả | Việc cần làm |
|---|---|
| `0` | Import bình thường |
| `41` | **Đã import rồi**, bỏ qua bước này (import lại sẽ báo trùng bảng) |
| Số khác | DB đang dở dang. Xoá và tạo lại DB trước khi import, hoặc hỏi lại |
| Lỗi đăng nhập | DB mới khởi động, đợi khoảng 15 giây rồi thử lại |

File dump **không có** lệnh `CREATE DATABASE`, nên cần tạo trước (với Cách A, `docker run` ở trên đã tạo sẵn DB `team2026`).

Cách A (Docker):

```bash
cd ~/Documents/Games/SOURCETEAMOBI2026
docker exec -i nro-mariadb mariadb -uroot -pnro123 team2026 < "database team2026.sql"
docker exec nro-mariadb mariadb -uroot -pnro123 team2026 -e "SHOW TABLES;" | wc -l
```

Cách B/C:

```bash
mysql -u root -p -e "CREATE DATABASE team2026 CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;"
mysql -u root -p team2026 < "database team2026.sql"
mysql -u root -p team2026 -e "SHOW TABLES;" | wc -l
```

Lệnh cuối phải in `42` (41 bảng cộng 1 dòng tiêu đề).

> Dùng file `database team2026.sql` ở thư mục gốc. File `SRC/sql/nro1.sql` là bản cũ hơn (xuất tháng 9/2025, tên DB gốc là `a`), nội dung khác bản trên.

### Bước 4. Chỉnh `SRC/Config.properties`

**Kiểm tra trước khi làm** (`bash kiem_tra_truoc_khi_cai.sh 4`)

```bash
cp SRC/Config.properties SRC/Config.properties.bak     # sao lưu trước khi sửa
grep -nE "server\.(ip|port|sv[0-9]+)|database\." SRC/Config.properties
docker port nro-mariadb 3306/tcp                       # in cổng thật của DB, ví dụ 0.0.0.0:3307
ipconfig getifaddr en0                                 # IP LAN của Mac, dùng cho server.ip nếu client ở máy khác
```

Cần chú ý:
- `database.port` phải bằng cổng mà `docker port` in ra.
- Còn dòng `server.svN` thì xem mục 4.1 trước khi quyết định xoá hay giữ.

Mở file và sửa các dòng sau cho khớp máy của bạn:

```properties
#SERVER
server.ip=127.0.0.1          # IP mà client sẽ kết nối tới (chạy local thì để 127.0.0.1)
server.port=14445
server.name=NRO
server.maxplayer=1000
server.expserver=3           # tỉ lệ exp

# XOÁ hoặc comment dòng này khi chạy riêng (xem mục 4.1):
# server.sv1=NroLight:fw.patus.tech:14449:0,0,0

#DATABASE
database.host=localhost
database.port=3307           # 3307 nếu dùng Docker (Cách A), 3306 nếu cài thẳng MariaDB
database.name=team2026
database.user=root
database.pass=nro123         # đúng với MARIADB_ROOT_PASSWORD đã đặt ở Bước 2
```

Ý nghĩa nhanh:

- `server.ip` + `server.port` được ghép vào danh sách server gửi cho client.
- `server.sv1` … `server.sv10` là các server **bổ sung** trong danh sách chọn server của client.
- `database.min` / `database.max` là kích thước pool kết nối (hiện là 1/1).

### Bước 5. Chạy server

**Kiểm tra trước khi làm** (`bash kiem_tra_truoc_khi_cai.sh 5`)

```bash
cd ~/Documents/Games/SOURCETEAMOBI2026/SRC && pwd && ls Config.properties 20.jar data   # phải thấy đủ 3 mục
java -version                                                                          # 17 trở lên
lsof -nP -iTCP:14445 -sTCP:LISTEN                                                      # không in gì = cổng còn trống
nc -z localhost 3307 && echo "DB mở cổng" || echo "DB CHƯA chạy"                       # đổi 3307 theo database.port
```

Lỗi thường gặp nếu bỏ qua bước này: chạy sai thư mục (`Lỗi load properites`), DB chưa chạy hoặc sai mật khẩu (`Database loading error`), cổng bị chiếm (`Error initializing server`).

```bash
cd SRC
java -server -Dfile.encoding=UTF-8 -jar 20.jar
```

Trên Windows: chạy `SRC/run.bat`.

Khi khởi động thành công, log có dòng dạng:

```
Server initialized and listening on port 14445
```

Nếu thấy `Lỗi load properites` hoặc `Database loading error` rồi server tự thoát, xem mục 5.

### Bước 6. Tạo tài khoản đăng nhập

**Kiểm tra trước khi làm** (`bash kiem_tra_truoc_khi_cai.sh 6`)

```bash
docker exec nro-mariadb mariadb -uroot -pnro123 team2026 -e \
  "SELECT id, username, is_admin FROM account WHERE username IN ('mytest','1','11','111');"
```

- Nếu `mytest` đã có dòng: đổi tên khác, `username` không được trùng và tối đa 20 ký tự.
- Nếu thấy `1`, `11`, `111` có `is_admin = 1`: đó là tài khoản admin mặc định mật khẩu 1 ký tự. Có thể dùng để thử, nhưng đổi hoặc xoá trước khi mở server ra ngoài.

Server không kèm web đăng ký. Thêm tài khoản trực tiếp vào DB (mật khẩu lưu **plain text**, login chạy `select * from account where username = ? and password = ?`).
Các cột `token`, `xsrf_token`, `newpass` là `NOT NULL` không có default nên cần điền chuỗi rỗng:

```sql
INSERT INTO account (username, password, email, token, xsrf_token, newpass, is_admin, active)
VALUES ('mytest', 'mypass123', '', '', '', '', 1, 1);
```

- `is_admin = 1` cho phép dùng lệnh admin trong chat (xem `Lệnh admin.docx`). Tài khoản thường để `0`.
- `active = 1` nếu muốn tài khoản đã kích hoạt.
- Nếu `id` báo lỗi, bảng `account` có `AUTO_INCREMENT` nên thường không cần truyền `id`.

> Dump có sẵn 3 tài khoản admin tên `1`, `11`, `111` mật khẩu 1 ký tự. **Đổi hoặc xoá chúng** trước khi mở server ra internet.

### Bước 7. Chạy client

**Kiểm tra trước khi làm** (`bash kiem_tra_truoc_khi_cai.sh 7`)

```bash
lsof -nP -iTCP:14445 -sTCP:LISTEN     # phải in ra tiến trình java: server đang chạy
grep "^server.ip" SRC/Config.properties
ipconfig getifaddr en0                # so với server.ip
uname -sm                             # Darwin arm64 = Mac: KHÔNG chạy trực tiếp được file .exe
```

- `server.ip=127.0.0.1` chỉ đúng khi client chạy cùng máy. Client ở VM hoặc máy Windows khác thì `server.ip` phải là IP LAN của Mac.
- Mac không chạy `XUNGLORDLOCAL.exe` trực tiếp: dùng máy ảo Windows (Parallels/UTM) hoặc máy Windows khác trong cùng mạng.
- Máy chạy client phải kết nối được `IP_Mac:14445` (tường lửa không chặn).

1. Trên Windows, chạy `LÂU CỒ MOD/XUNGLORDLOCAL.exe`.
2. Đăng nhập bằng tài khoản vừa tạo ở bước 6.
3. Chọn server tên trùng `server.name` trong config.

Địa chỉ server ban đầu mà client dùng **chưa xác định được** từ file (xem mục 4.3).

### Bước 8 (tuỳ chọn). Lệnh điều khiển trong console server

**Kiểm tra trước khi làm** (`bash kiem_tra_truoc_khi_cai.sh 8`)

```bash
lsof -nP -iTCP:14445 -sTCP:LISTEN     # phải có: server đang chạy, bạn gõ lệnh vào cửa sổ của nó
```

Lệnh `bt` lưu dữ liệu rồi **tắt server**. Đừng gõ khi có người đang chơi.

Gõ trực tiếp vào cửa sổ đang chạy server:

| Lệnh | Tác dụng |
|---|---|
| `bt` | Bảo trì server sau 5 giây (lưu dữ liệu rồi thoát) |
| `bat` / `tat` | Bật / tắt chế độ bảo trì tự động |
| `run` | Chạy `run.bat` (chỉ dùng được trên Windows) |

Lưu ý: sau bảo trì server gọi `cmd /c start restart_server.bat` để tự khởi động lại. Lệnh này **chỉ có trên Windows**. Trên macOS/Linux server sẽ chỉ thoát, bạn cần tự chạy lại hoặc dùng systemd/supervisor.

### Bước 9 (tuỳ chọn). Build lại từ source

**Kiểm tra trước khi làm** (`bash kiem_tra_truoc_khi_cai.sh 9`)

```bash
javac -version                          # phải có JDK 17+ (JRE không đủ)
ls SRC/src SRC/nbproject/project.xml SRC/lib
cp SRC/20.jar SRC/20.jar.bak            # sao lưu bản chạy được trước khi thay
lsof -nP -iTCP:14445 -sTCP:LISTEN       # nên không in gì: tắt server trước khi build
```

Nếu sửa code `SRC/src/`:

1. Mở thư mục `SRC/` bằng **Apache NetBeans** (project dạng Ant, JDK 17, có sẵn `nbproject/`).
2. Chọn Clean and Build. Output là `SRC/dist/NgocRongOnline.jar` cùng thư mục `dist/lib/`.
3. Chạy bản build mới: `cd SRC/dist && java -jar NgocRongOnline.jar`. Nhớ copy `Config.properties` và thư mục `data/` ra cùng chỗ chạy, vì server đọc chúng theo đường dẫn tương đối.

`20.jar` trong `SRC/` là bản đóng gói sẵn gồm cả thư viện, đã khớp với source hiện tại (548 class `nro.*`).

---

## 4. Lưu ý / Chưa xác định

### 4.1. Dòng `server.sv1` trỏ tới máy chủ bên ngoài

`Config.properties` hiện có:

```
server.sv1=NroLight:fw.patus.tech:14449:0,0,0
```

Code (`Manager.loadProperties` và `DataGame.sendLinkIP`) nối dòng này vào danh sách server gửi cho client. Nghĩa là người chơi sẽ thấy thêm server "NroLight" và nếu chọn, **client sẽ kết nối và gửi tài khoản/mật khẩu tới `fw.patus.tech`**, không phải server của bạn. Server Java của bạn không tự kết nối ra ngoài, nhưng nếu không chủ ý dùng thì hãy xoá dòng này.

> Đính chính báo cáo bảo mật trước: lần quét trước chỉ tìm domain trong file `.java` nên bỏ sót dòng này.

### 4.2. Tương thích database

- Driver `mysql-connector-java 5.1.23` rất cũ, **không hỗ trợ** `caching_sha2_password` của MySQL 8. Nếu dùng MySQL 8, hãy đổi user sang `mysql_native_password`:
  ```sql
  ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'mật_khẩu';
  ```
  hoặc dùng MariaDB cho đơn giản.
- Bản driver trong `lib/` là bản đã biên dịch lại sang Java 8, không trùng hash với bản gốc Maven Central (xem báo cáo bảo mật). Nếu muốn chắc chắn, thay bằng `mysql-connector-java-5.1.49` chính thức.

### 4.3. Địa chỉ server phía client

Không tìm thấy IP/cổng server dạng chữ trong `GameAssembly.dll`, metadata hay các file `.assets` của client. Có thể nó được mã hoá, nằm trong code IL2CPP hoặc lấy từ nơi khác. Hệ quả:

- Mình **chưa biết** client đang trỏ vào `127.0.0.1` hay một IP cố định.
- Nếu client không kết nối được server local, cần xác định lại nơi cấu hình địa chỉ (hỏi người cung cấp client, hoặc chạy client trong VM và xem kết nối bằng Wireshark).

### 4.4. IP hardcode trong source

| IP | Vị trí | Ghi chú |
|---|---|---|
| `36.50.135.16` | `Config.properties` (`server.ip`) | Nên đổi theo máy của bạn |
| `36.50.135.149` | `ServerManager.IP` (ghi đè bởi config), `TaskService.loadTask` | `loadTask` đang bị comment |
| `36.50.134.190` | `DataGame.LINK_IP_PORT` | Giá trị mặc định, bị ghi đè khi đọc config |

Hai hàm khoá IP (`ShopTab.loadItem`, `TaskService.loadTask`) hiện **đang bị comment** ở `ServerManager.java` (dòng 85 và 70). **Đừng bỏ comment**, nếu không server sẽ tự tắt khi IP máy khác IP cấu hình. Nên xoá hẳn hai hàm này nếu bạn build lại.

### 4.5. Cấu hình chưa khớp

`ServerManager.resetNhanQuaHangNgay()` tự kết nối `jdbc:mysql://localhost:3306/ngocrong` bằng user `root` mật khẩu rỗng (không dùng `Config.properties`). Hàm này sẽ lỗi nếu bạn không có DB tên `ngocrong`. Sửa để dùng chung cấu hình DB nếu bạn cần tính năng reset nhận quà hằng ngày.

### 4.6. Bảo mật khi mở ra internet

- Mật khẩu tài khoản game lưu plain text trong bảng `account`.
- Mật khẩu DB nằm plain text trong `Config.properties`. Đừng đưa file này lên git công khai.
- Đổi hoặc xoá 3 tài khoản admin mặc định (`1`, `11`, `111`).
- Chỉ mở cổng `14445`; không mở `3306` ra ngoài.

---

## 5. Xử lý sự cố nhanh

| Triệu chứng | Nguyên nhân thường gặp | Cách xử lý |
|---|---|---|
| `Lỗi load properites` rồi thoát | Chạy `java -jar` không đứng trong thư mục `SRC/` (không thấy `Config.properties`) | `cd SRC` rồi chạy lại |
| `Database loading error` rồi thoát | Sai thông tin DB, chưa import dump, hoặc DB chưa chạy | Kiểm tra `database.*`, đảm bảo DB `team2026` đã có 41 bảng |
| `Communications link failure` / lỗi xác thực | MySQL 8 với `caching_sha2_password` | Xem mục 4.2 |
| `Error initializing server at port 14445` | Cổng đang bị chương trình khác chiếm | Đổi `server.port` hoặc tắt tiến trình đang giữ cổng |
| Server tự thoát sau vài giây | Khoá IP bị bật lại ở `ServerManager` | Giữ nguyên dòng đang comment, xem mục 4.4 |
| `Failed to initialize pool: java.lang.NullPointerException` ở `buildCollationMapping` | Dùng MariaDB 10.10 trở lên (có collation `uca1400_*` ID rỗng) | Dùng `mariadb:10.6`, tạo lại container và volume (xem Bước 2) |
| Tiếng Việt lỗi font | Thiếu mã hoá UTF-8 | Chạy với `-Dfile.encoding=UTF-8`, DB dùng `utf8mb4` |
| Client không thấy server | Sai `server.ip`, tường lửa chặn `14445`, hoặc client trỏ sai địa chỉ | Xem mục 4.3 |
