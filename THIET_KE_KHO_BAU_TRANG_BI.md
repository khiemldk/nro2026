# Thiết kế kho báu Poneglyph và trang bị (One Piece, đến Marineford)

Chưa sửa code nào. Hình ảnh dùng lại asset cũ. Skill và Trái Ác Quỷ nằm trong `THIET_KE_SKILL_TRAI_AC_QUY.md`.

**Nhãn:** [CHỐT] bạn đã đồng ý. [ĐỀ XUẤT] mình đề xuất, chưa xác nhận. [ĐÃ ĐỌC] lấy từ code hoặc DB gốc. [CHƯA KIỂM TRA] chưa đọc.

---

## 1. Poneglyph thay ngọc rồng

- Hệ thống ước Rồng thần bị bỏ [CHỐT]. Ngọc rồng gốc là item id 14–20 [ĐÃ ĐỌC].
- Có **3 loại phiến khác nhau** [CHỐT]. Ba loại này tương ứng ba loại vé, mỗi vé dùng **một lần** [CHỐT].

| Loại phiến | Số phiến | Vé dẫn tới |
|---|---|---|
| **Road Poneglyph** | 4 | Map kiểu **doanh trại** của NRO [CHỐT] |
| **Historical Poneglyph** | 9 | **"Như ước":** chọn một phần thưởng trong danh sách [CHỐT ý, danh sách ĐỀ XUẤT ở mục 3] |
| **Instructional / Informational** | 17 | Map riêng, khác map của vé 4: có Enel, đồ VIP [CHỐT] |

- NV8 cho phiến đầu tiên (tương đương "tìm ngọc 7 sao" gốc) [ĐỀ XUẤT].
- Nguồn phiến từng loại [ĐỀ XUẤT, chưa chốt]:
  - Road: rơi từ quái và nhiệm vụ.
  - Historical: rơi từ boss theo chặng cốt truyện.
  - Informational: rơi từ boss lớn.
- Đổi phiến lấy vé tại **Nico Robin** (người đọc được Poneglyph trong nguyên tác) [ĐỀ XUẤT].

## 2. Ba loại map

### 2.1 Vé 4 phiến: doanh trại độc nhãn được dùng lại
Doanh trại gốc không còn là hoạt động của bang hội. Nó **trở thành map của vé 4 phiến** [CHỐT]. Cơ chế gốc [ĐÃ ĐỌC `RedRibbonHQ.java`, `LinhCanh.java`]:

| Điểm | Game gốc | Cho vé 4 phiến |
|---|---|---|
| Vào | Qua NPC Lính Canh, theo bang hội. Thành viên phải ở trong bang ít nhất 1 ngày và đứng trong vùng cổng | Dùng vé 4 phiến, người mở cổng đưa cả nhóm (thuyền) vào [ĐỀ XUẤT] |
| Giới hạn | 1 lần mỗi ngày mỗi người | Vé dùng một lần là giới hạn, bỏ giới hạn theo ngày [ĐỀ XUẤT] |
| Thời gian | 30 phút | Giữ 30 phút |
| Chuỗi ải | Map 53 (vào) → 54 (Ninja áo tím) → 55 (Trung úy thép) → 57 (4 Robot vệ sĩ) → 59 (Trung úy trắng) → 62 (Trung úy xanh lơ) | Giữ cấu trúc, đổi tên (xem dưới) |
| Độ mạnh quái và boss | Tính từ **tổng sát thương và tổng máu của các thành viên bang** đang vào, boss nhân 1,0–1,3 | Giữ: mạnh theo nhóm đi cùng [ĐỀ XUẤT] |
| Cuối | Có 5 phút "tìm ngọc 4 sao và ngọc 7 sao" giấu trong doanh trại | Đổi thành tìm phiến Poneglyph [ĐỀ XUẤT] |

Đổi tên boss cho chủ đề Baroque Works / di tích [ĐỀ XUẤT]: Ninja áo tím → Mr.3; Trung úy thép → Miss Doublefinger; 4 Robot vệ sĩ → 4 Pacifista; Trung úy trắng → Mr.2 Bon Clay; Trung úy xanh lơ → Mr.1 Daz Bones.

### 2.2 Vé 9 phiến: chọn phần thưởng (xem mục 3)

### 2.3 Vé 17 phiến: map kho báu có Enel
Dựa trên "Bản đồ kho báu" có sẵn trong game gốc [ĐÃ ĐỌC `BanDoKhoBau.java`, `QuyLaoKame.java`, `TreasureUnderSeaService.java`]:

| Điểm | Game gốc | Thiết kế mới |
|---|---|---|
| Cấp | 1 → 110, chọn tự do | **1 → 30** [CHỐT], phải **qua cấp này mới mở cấp sau** [CHỐT] |
| Lưu tiến độ | Theo bang hội | **Theo người** [CHỐT] |
| Ý nghĩa cấp | Nhân máu và sát thương quái, boss | **Máu của quái và boss trong map** [CHỐT] |
| Thời gian mỗi lượt | 30 phút | Giữ 30 phút [ĐỀ XUẤT] |
| Vào | Qua NPC Quy Lão Kame, theo bang hội | Qua vé 17 phiến. Người dùng vé mở cổng cho cả nhóm/thuyền cùng vào [ĐỀ XUẤT] |
| Boss cuối | Boss thường | **Enel**, mạnh theo cấp [CHỐT] |

Công thức gốc [ĐÃ ĐỌC]: boss cuối máu = 20.000.000 × cấp, sát thương = 200.000 × cấp; quái máu = cấp × 469.799 × (mã quái). Ở cấp 30 boss máu 600.000.000, sát thương 6.000.000. Mình giả định phần sát thương cũng tăng theo cấp như gốc [ĐỀ XUẤT].

**Thưởng theo cấp** [CHỐT ý, số chưa có]:
- Cấp thấp: vàng và vật phẩm thường.
- Cấp cao nhất (cấp 30): đồ cấp cao, và Enel có **tỉ lệ rơi thấp** ra **Trái Sét** [CHỐT].
- Trái Sét **chỉ rơi từ Enel**, không mua được [CHỐT].

## 3. Vé 9 phiến "như ước": danh sách đề xuất

Dựa trên các điều ước của rồng thần gốc [ĐÃ ĐỌC `SummonDragon.java`]: vàng, sức mạnh/tiềm năng, nâng găng hoặc quần lên 1 cấp, chí mạng gốc +2%. Người chơi chọn **một**:

| # | Phần thưởng | Ghi chú |
|---|---|---|
| 1 | Một khoản Berry lớn | Số lượng ở Phần 4 |
| 2 | Một khoản sức mạnh + tiềm năng | Số lượng ở Phần 4 |
| 3 | Nâng một món trang bị đang mặc thêm +1 cấp | Có giới hạn cấp tối đa được nâng bằng cách này |
| 4 | Chí mạng gốc +2% | Cộng vĩnh viễn, có trần |
| 5 | Một gói nguyên liệu nâng cấp | |
| 6 | Một trái Hiếm của hệ mình | Giá trị cao nhất, cân bằng ở Phần 4 |

Danh sách và con số: [ĐỀ XUẤT], chưa chốt.

## 4. Trang bị

Nguyên tắc [CHỐT]: bớt kiểu NRO có hàng trăm áo quần giày. Mỗi nhân vật có **một bộ đồ riêng** để tiết kiệm hình ảnh. Sau đó là nâng cấp đồ.

### 4.1 Game gốc hiển thị gì trên người [ĐÃ ĐỌC `Player.java`, `Char.cs`]

| Lớp | Lấy từ | Ghi chú |
|---|---|---|
| Đầu | Kiểu tóc đã chọn, hoặc ô 5 (cải trang) | Ô 5 ghi đè độc lập từng phần |
| Thân | Ô 0 (áo), hoặc ô 5 | |
| Chân | Ô 1 (quần), hoặc ô 5 | |
| Lưng | Ô 8, hoặc cờ bang hội nếu không có | |
| Thú cưỡi | Ô 9 | |
| Hào quang | Thẻ radar (6 thẻ cụ thể, cấp > 1) | |
| Hiệu ứng set | Khi cả 5 ô 0–4 cùng đạt cấp nâng yêu cầu | Server trả hiệu ứng, client vẽ quanh người |

Găng, giày và ô 4 **không đổi hình**. Vũ khí cầm tay **không có**.

### 4.2 Thiết kế ô trang bị [CHỐT]

| Ô | Dùng cho | Hiện lên người? |
|---|---|---|
| Áo | Thân của nhân vật chọn | Có |
| Quần | Chân của nhân vật chọn | Có |
| Găng | Chỉ số | Không |
| Giày | Chỉ số | Không |
| Phụ kiện (ô 4, trước là rada) | Chỉ số | Không |
| Mũ / khăn / tóc (ô 5, giống **cải trang** của NRO) | Đầu | Có |

- **Vũ khí: tạm bỏ qua** [CHỐT].
- **Rada chưa có**, ô 4 dùng làm **phụ kiện** [CHỐT]. Hệ sưu tầm thẻ radar và hào quang từ thẻ cũng chưa dùng.
- Mũ/khăn/tóc dùng đúng cơ chế ô 5 (cải trang) của game gốc: item chỉ đặt `head`, để `body` và `leg` là -1, nên chỉ ghi đè đầu [ĐÃ ĐỌC logic `getHead`/`getBody`/`getLeg`; chưa thử]. Việc này chỉ cần dữ liệu và part hình < 2000.
- Hiệu ứng set tính trên 5 ô 0–4 (áo, quần, găng, giày, phụ kiện) [ĐÃ ĐỌC `getEffFront`]. Ô 5 (mũ) không tính.
- **9 bộ đồ**: 3 phe × 3 nhân vật chọn. Nhân vật chọn có thể là kiểu tóc có sẵn lúc tạo nhân vật [ĐỀ XUẤT, chưa kiểm tra tóc gắn với bộ đồ thế nào].

### 4.3 Nâng cấp và hiệu ứng [CHỐT ý]

- **Hành trang:** mỗi bậc nâng cấp đổi màu hoặc hiệu ứng icon. Làm bằng dữ liệu: mỗi bậc là một dòng item riêng, **dùng chung `part`** (hình trên người) nhưng khác `icon_id` (hình trong hành trang) [ĐỀ XUẤT cách làm]. Hình trên người không đổi.
- **Hiệu ứng ngoài người:** khi cả 5 món đạt **+4, +7 và +10** thì hiện hiệu ứng, giống hào quang Siêu Xayda hiện tại [CHỐT]. Game gốc có 5 mức hiệu ứng (+4 đến +8); thiết kế mới chỉ dùng 3 mức, có thể dùng 3 hiệu ứng có sẵn trong client, không cần build lại client [ĐỀ XUẤT, chưa kiểm tra].
- Hình trên người nhân vật giữ nguyên ngoài hiệu ứng set.
- **Trần nâng cấp là +10** [CHỐT].
- **Rủi ro ở +4, +7, +10** [CHỐT ý, số ĐỀ XUẤT]: nâng lên các mốc này có thể **thất bại**. Thất bại không mất cấp và không phá đồ, chỉ **giảm 1% sức mạnh (chỉ số) của chính món đó**. Các bước khác (+1, +2, +3, +5, +6, +8, +9) không thất bại.

| Nâng lên | Tỉ lệ thành công |
|---|---|
| +1 đến +3 | 100% |
| **+4** | **80%** |
| +5, +6 | 100% |
| **+7** | **60%** |
| +8, +9 | 100% |
| **+10** | **40%** |

- Mỗi lần thất bại trừ thêm 1% và cộng dồn, tối đa trừ 10% [ĐỀ XUẤT]. Mình chọn trần để người chơi không bị phạt vô hạn.
- Phí nâng cấp (Berry và nguyên liệu): chưa quyết, làm ở Phần 4.
- Cách nâng cấp gốc (`NangCapVatPham`), tỉ lệ nằm trong dữ liệu hay trong code, và trần gốc: [CHƯA KIỂM TRA].

## 5. Tỉ lệ và số liệu [ĐỀ XUẤT, bạn bảo "chọn hợp lý", chưa thử trên server]

Mục tiêu nhịp chơi: một người chơi đều đặn có **vé 4 khoảng mỗi ngày**, **vé 9 khoảng mỗi 2–3 ngày**, **vé 17 khoảng mỗi 2 tuần**.

### 5.1 Nguồn phiến

| Loại phiến | Nguồn | Tỉ lệ |
|---|---|---|
| Road (cần 4) | Quái thường ở các chặng cốt truyện | 0,5% mỗi con (cần khoảng 800 con, 1–1,5 giờ cày) |
| Historical (cần 9) | Boss theo chặng và boss thế giới | 20% mỗi boss (cần khoảng 45 boss) |
| Informational (cần 17) | Mỗi lần hoàn thành map vé 4 (doanh trại) được 1 phiến chắc chắn, boss lớn thêm 10% | Khoảng 2 tuần chơi đều |

### 5.2 Thưởng map vé 17 theo cấp (Enel)

| Cấp | Thưởng |
|---|---|
| 1–10 | Berry = cấp × 1.000.000 (cấp 1 = 1 triệu, cấp 10 = 10 triệu), vật phẩm thường |
| 11–20 | Berry = cấp × 1.000.000, nguyên liệu nâng cấp |
| 21–29 | Berry = cấp × 1.000.000, nguyên liệu và đồ cấp cao, trái Hiếm hoặc Thần thoại với tỉ lệ thấp |
| 30 | Berry 30 triệu, đồ cấp cao chắc chắn, **Trái Sét 1% mỗi lần hạ Enel** (khoảng 1 trái trên 100 lượt cấp 30) |

Phần thưởng Berry cùng cỡ với nhiệm vụ phụ gốc nhặt vàng (tới 100 triệu ở cấp cao nhất) [ĐÃ ĐỌC `side_task_template`].

### 5.3 Vé 9 phiến "như ước"

| Phần thưởng | Lượng |
|---|---|
| Berry | 20.000.000 |
| Sức mạnh + tiềm năng | 20.000.000 mỗi loại (cùng cỡ ước 2 sao gốc) |
| Nâng một món +1 cấp | Chỉ nâng được món dưới +6, không qua các mốc rủi ro |
| Chí mạng gốc | +2%, tối đa nhận 3 lần |
| Gói nguyên liệu nâng cấp | 1 gói |
| Trái Hiếm của hệ mình | 1 trái |

## 6. Chưa làm / chưa quyết

- Phí nâng cấp trang bị (Berry và nguyên liệu).
- Cách nâng cấp gốc, nơi lưu tỉ lệ (dữ liệu hay code): cần đọc `combine`.
- Client có hiển thị đúng 5 ô trang bị + ô 5 (cải trang) với phụ kiện thay rada không: cần đọc `Panel.cs`.
- Các tỉ lệ ở mục 5 chỉ là điểm xuất phát, cần chơi thử để chỉnh.
- Cốt truyện đến Marineford: xem `THIET_KE_COT_TRUYEN.md`.
