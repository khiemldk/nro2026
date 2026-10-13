# Hệ thống hoá game Ngọc Rồng Online (bản gốc) để làm lại thành One Piece

Tài liệu này mô tả **game gốc chưa sửa**. Không có gì của One Piece trong đó. Dùng nó làm nền để quyết định cái gì giữ, cái gì đổi.

**Nguồn đã đọc:**
- `Nro/database team2026.sql`: dump DB gốc, 41 bảng. Server dùng DB `team2026` (`SRC/Config.properties`).
- Code server `Nro/SRC/src/nro/models/**`: `PlayerDAO`, `NPoint`, `Service`, `TaskService`, `OpenPowerService`, `QuocVuong`, `ToSuKaio`, `SummonDragon`, `SummonDragonNamek`, `Clan`, `ClanService`, `Fusion`, `Pet`.
- `NHIEM_VU.md` và `COT_TRUYEN_NRO.md` (bản cũ). Tôi đã kiểm tra lại và sửa các chỗ sai, xem mục 0.

**Nhãn:**
- **ĐÃ ĐỌC**: lấy từ DB hoặc code (kèm nguồn).
- **CHƯA KIỂM TRA**: chưa đọc hoặc chỉ suy luận. Mục 12 gom hết các phần này.

---

## 0. Những chỗ tài liệu cũ sai hoặc thiếu (đã sửa trong file này)

| # | Tài liệu cũ nói | Thực tế (ĐÃ ĐỌC) |
|---|---|---|
| 1 | "Không thấy nội tại riêng theo hành tinh" | **Có.** Bảng `intrinsic` có 208 dòng: gender 0 = 56, gender 1 = 64, gender 2 = 56, gender 3 (chung) = 32. Mỗi nội tại là buff theo từng skill của hành tinh đó (mục 4). |
| 2 | Có hai skill trùng ô 6 | Sai. Cột `slot` đánh số **0–8 và không trùng** trong mỗi hành tinh. Bảng skill ở mục 3 đã xếp lại đúng. |
| 3 | Thưởng NV1 "200tr vàng", NV2 "300tr vàng"... lấy từ chữ mô tả | Chữ mô tả trong DB chỉ là text hiển thị. **Code thưởng khác hẳn** (mục 5.2): NV1 là 1.000 sức mạnh + 1.000 tiềm năng + 100.000 vàng. |
| 4 | Cấp bậc "mốc sức mạnh chưa đọc" | Đã đọc. Có bảng mốc đầy đủ ở mục 2.4, và 2 cấp cuối trong `ListCaption` không bao giờ đạt được. |
| 5 | Người chơi mới "bắt đầu từ 0" | Bắt đầu với 2.000 sức mạnh, 2.000 tiềm năng, 2.000 vàng, 10.000 ngọc xanh (mục 1). |
| 6 | Nhiệm vụ 27 "nâng sức đánh gốc lên 10K" | Tên bước ghi 10K, nhưng `notify` của chính bước đó ghi **35K**. DB tự mâu thuẫn. |
| 7 | Chỉ nói "giới hạn sức mạnh" chung chung | Có 10 bậc giới hạn (mục 2.3), mở bằng thời gian hoặc 50 triệu vàng. |

**Cảnh báo về DB đang chạy:**
- Container `nro-mariadb` (DB `team2026`) hiện có **82 bảng**, bản gốc chỉ có 41.
- Bảng thừa gồm 6 bảng `devil_fruit*`, `task_step_rule`, `task_main_reward`, `quest_boss`, `sea_route`, `map_task_gate` và 28 bảng `_bak*`.
- Tên skill và nhiệm vụ trong DB đó vẫn là bản One Piece cũ.
- Code `OnePiece/SRC` đã về bản gốc, nên DB live và code **đang lệch nhau**. Trước khi làm lại, nạp lại `database team2026.sql` vào DB sạch.

---

## 1. Chọn hành tinh và tạo nhân vật

**Nguồn:** `PlayerDAO.createNewPlayer` (ĐÃ ĐỌC).

Người chơi chọn 3 thứ: **hành tinh (gender 0/1/2)**, **kiểu tóc (`hair`)** và **tên**. Hành tinh quyết định gần như mọi thứ còn lại.

| | Trái Đất (0) | Namếc (1) | Xayda (2) |
|---|---|---|---|
| HP gốc | 200 | 100 | 100 |
| KI gốc | 100 | 200 | 100 |
| Sức đánh gốc | 10 | 10 | 15 |
| Áo / Quần khởi đầu (id item) | 0 / 6 | 1 / 7 | 2 / 8 |
| Áo: option 47 (giáp) | +2 | +2 | +3 |
| Quần: option 6 (HP) | +30 | +20 | +20 |
| Map xuất hiện | 39 | 40 | 41 |

- Map xuất hiện = `39 + gender`. Trong `map_template`, map 39/40/41 tên là "Vách núi Aru / Vách núi Moori / Vực Plant". Nhà là map 21/22/23.
- Hành trang đầu game: 10 thỏi vàng (item 63) và rada (item 12). Nguồn: `PlayerDAO` dòng 126–160.
- Sức mạnh gốc, tiềm năng, thể lực: xem bảng "Chỉ số khởi đầu chung" ngay dưới.
- Số liệu "sức đánh gốc 10/10/15" lấy từ ghi chú của bản cũ, tôi **chưa kiểm tra lại** dòng này trong `PlayerDAO`.

**Chỉ số khởi đầu chung (ĐÃ ĐỌC):**

| Mục | Giá trị |
|---|---|
| Vàng | 2.000 |
| Ngọc xanh | 10.000 (1 tỷ nếu `Manager.TEST`) |
| Hồng ngọc | 0 |
| Sức mạnh | 2.000 |
| Tiềm năng | 2.000 |
| Thể lực | 1.000 / 1.000 |

**Tên theo hành tinh trong nhiệm vụ (placeholder `%1..%14`):** ĐÃ ĐỌC trong `TaskService.transformName`.

| Mã | Trái Đất | Namếc | Xayda |
|---|---|---|---|
| %1 Làng | Làng Aru | Làng Mori | Làng Kakarot |
| %2 Người nuôi | ông Gôhan | ông Moori | ông Paragus |
| %3 Map ~200 sức mạnh | Đồi hoa cúc | Đồi nấm tím | Đồi hoang |
| %4 Quái đầu | khủng long | lợn lòi | quỷ đất |
| %5 Vách núi | Vách núi Aru | Vách núi Moori | Vách núi Kakarot |
| %6 Map ~500 | Thung lũng tre | Thị trấn Moori | Làng Plant |
| %7 NPC trạm tàu | Dr. Brief | Cargo | Cui |
| %8 NPC cửa hàng làng | Bunma | Dende | Appule |
| %9 Quái bay | thằn lằn bay | phi long | quỷ bay |
| %10 Sư phụ | Quy Lão Kame | Trưởng lão Guru | Vua Vegeta |
| %11 Nơi ở sư phụ | Đảo Kamê | Đảo Guru | Vách núi đen |
| %12 Quái ~3000 | ốc mượn hồn | ốc sên | heo Xayda mẹ |
| %13 Map ~600 | Rừng nấm | Thung lũng Namếc | Rừng nguyên sinh |
| %14 Quái mẹ ~1000 | phi long mẹ | quỷ bay mẹ | thằn lằn mẹ |

**Ràng buộc kỹ thuật:**
- Gender chỉ có 3 giá trị 0/1/2. Đổi chỗ gender xuất hiện (trang bị, skill, đệ tử, NPC, nhiệm vụ) là sửa code server và có thể sửa cả màn tạo nhân vật của client.
- Chỉ số khởi đầu, trang bị khởi đầu và map xuất hiện **gắn cứng trong `PlayerDAO.java`**, không nằm DB.
- Các placeholder `%1..%14` **gắn cứng trong `TaskService.transformName`**, không nằm DB.

---

## 2. Sức mạnh, cấp bậc, giới hạn

### 2.1 Game không có level
Tiến độ nhân vật chỉ có **sức mạnh (power)** và **tiềm năng (potential)**. Tiềm năng dùng để cộng chỉ số. Cấp bậc chỉ là tên hiển thị suy ra từ sức mạnh.

### 2.2 Cấp bậc theo sức mạnh
**Nguồn:** `Service.getCurrLevel` và `ListCaption` (ĐÃ ĐỌC).

| Sức mạnh | Cấp bậc hiển thị |
|---|---|
| < 3.000 | Tân thủ |
| 3.000 – 15.000 | Tập sự sơ cấp |
| 15.000 – 40.000 | Tập sự trung cấp |
| 40.000 – 90.000 | Tập sự cao cấp |
| 90.000 – 170.000 | Tân binh |
| 170.000 – 340.000 | Chiến binh |
| 340.000 – 700.000 | Chiến binh cao cấp |
| 700.000 – 1,5 triệu | Vệ binh |
| 1,5 – 15 triệu | Vệ binh hoàng gia |
| 15 – 150 triệu | Siêu nhân / Siêu Namếc / Siêu Xayda cấp 1 |
| 150 triệu – 1,5 tỷ | Siêu … cấp 2 |
| 1,5 – 5 tỷ | Siêu … cấp 3 |
| 5 – 10 tỷ | Siêu … cấp 4 |
| 10 – 40 tỷ | Thần (hành tinh) cấp 1 |
| 40 – 50,01 tỷ | Thần … cấp 2 |
| 50,01 – 60,01 tỷ | Thần … cấp 3 |
| 60,01 – 70,01 tỷ | Giới Vương Thần cấp 1 |
| 70,01 – 80,01 tỷ | Giới Vương Thần cấp 2 |
| 80,01 – 90,01 tỷ | Giới Vương Thần cấp 3 |
| ≥ 90,01 tỷ | Thiên đạo |

Hai chuỗi cuối trong `ListCaption` ("kẻ hũy diệt vũ trụ", "vô địch đa giới") **không bao giờ đạt được**, vì hàm chỉ trả tối đa chỉ số 19.

Tên cấp "Siêu …" đổi theo hành tinh. Trái Đất gọi là "Siêu nhân", hai hành tinh kia dùng tên hành tinh.

### 2.3 Giới hạn sức mạnh (limitPower)
**Nguồn:** `NPoint.getPowerLimit`, `OpenPowerService`, `QuocVuong`, `ToSuKaio` (ĐÃ ĐỌC).

| Bậc `limitPower` | Trần sức mạnh |
|---|---|
| 0 | 17,999 tỷ |
| 1 | 19,999 tỷ |
| 2 | 24,999 tỷ |
| 3 | 29,999 tỷ |
| 4 | 39,999 tỷ |
| 5 | 50,01 tỷ |
| 6 | 60,01 tỷ |
| 7 | 70,01 tỷ |
| 8 | 80,01 tỷ |
| 9 (`MAX_LIMIT`) | 90,01 tỷ |

- Cách mở: chạm trần thì mới mở được (`canOpenPower`). Mở bằng 2 cách: chờ theo thời gian (`itemTime.isOpenPower`), hoặc "nâng ngay" tốn **50.000.000 vàng** (`COST_SPEED_OPEN_LIMIT_POWER`).
- NPC Quốc Vương (`QuocVuong.java`) mở được đến bậc 5. NPC Tổ Sư Kaio (`ToSuKaio.java`) mở bậc 5 → 9 và yêu cầu 50 tỷ sức mạnh.
- Đệ tử cũng có `limitPower` riêng và mở bằng cùng NPC.
- Công thức cộng sức mạnh khi đánh quái (`addSMTN`): sức mạnh và tiềm năng cùng cộng; đệ tử nhận đủ, chủ nhận 50%. Công thức chi tiết chưa đọc.

### 2.4 Công thức chỉ số, giá tiềm năng
**CHƯA KIỂM TRA** (cần đọc `NPoint.java` ~1.800 dòng): giá cộng HP/KI/sức đánh, giáp, chí mạng, công thức sát thương tổng.

---

## 3. Kỹ năng ba hành tinh

**Nguồn:** bảng `skill_template` trong `database team2026.sql`, 27 dòng (ĐÃ ĐỌC).
- `slot` đánh số từ 0 đến 8.
- Mỗi skill có 7 cấp, riêng đại chiêu ô 8 có 10 cấp.
- Dame là % sức đánh. `cd` là hồi chiêu tính bằng ms. Mana kiểu 0 = KI cố định, kiểu 1 = % KI tối đa, kiểu 2 = đặc biệt.

### 3.1 Trái Đất (gender 0)

| Ô | Skill (id) | Sức mạnh mở (cấp 1 → cuối) | Dame | Mana | Hồi chiêu | Tác dụng |
|---|---|---|---|---|---|---|
| 0 | Chiêu đấm Dragon (0) | 1.000 → 1,8 triệu | 100 → 160 | 1 → 70 | 0,5 s | Đấm thường |
| 1 | Kamejoko (1) | 10.000 → 4,8 triệu | 150 → 450 | 30 → 1.280 | 2 → 5 s | Chưởng tầm xa |
| 2 | Thái Dương Hạ San (6) | 60.000 → 30 triệu | choáng 3 → 9 s | 45% → 15% | 60 → 30 s | Làm choáng xung quanh |
| 3 | Kaioken (9) | 150 → 450 triệu | 160 → 220 | 9.000 → 27.000 | 0,5 s | Tăng sức đánh |
| 4 | Quả cầu kênh khí (10) | 500 triệu → 1,1 tỷ | 500 → 1.100 | 50% → 80% | 360 → 300 s | Sát thương diện rộng |
| 5 | Dịch chuyển tức thời (20) | 10 triệu → 15,6 tỷ | 1.000 → 4.000 | 5.000 → 30.000 | 20 → 14 s | Dịch chuyển, gây choáng |
| 6 | Thôi miên (22) | 10 triệu → 15,6 tỷ | ngủ 5 → 11 s | 10.000 | 30 → 42 s | Ru ngủ |
| 7 | Khiên năng lượng (19) | 10 triệu → 15,6 tỷ | 15 → 45 | 51% → 33% | 75 → 105 s | Vô hiệu đòn tấn công |
| 8 | Super Kamejoko (24) | 60 tỷ | 550 → 1.000 | 80% → 35% | 170 → 80 s | Đại chiêu, 10 cấp |

### 3.2 Namếc (gender 1)

| Ô | Skill (id) | Sức mạnh mở | Dame | Mana | Hồi chiêu | Tác dụng |
|---|---|---|---|---|---|---|
| 0 | Chiêu đấm Demon (2) | 1.000 → 1,8 triệu | 95 → 155 | 1 → 70 | 0,4 s | Đấm thường |
| 1 | Masenko (3) | 10.000 → 4,8 triệu | 100 → 160 | 8 → 512 | 0,8 → 0,7 s | Chưởng tầm xa |
| 2 | Trị thương (7) | 60.000 → 30 triệu | hồi 50 → 80% | 40% → 10% | 30 → 44 s | Hồi HP và KI đồng đội |
| 3 | Makankosappo (11) | 150 → 450 triệu | 70 → 130 | 0, kiểu mana 2 | 360 → 300 s | Nạp rồi bắn tia xuyên |
| 4 | Đẻ trứng (12) | 500 triệu → 1,1 tỷ | 50 → 80 | 20% → 80% | 360 → 540 s | Tạo quái đi theo |
| 5 | Liên hoàn (17) | 10 triệu → 15,6 tỷ | 160 → 190 | 100 → 700 | 0,35 → 0,33 s | Đòn liên tiếp |
| 6 | Biến Sôcôla (18) | 10 triệu → 15,6 tỷ | 15 → 27 | 22% → 10% | 30 → 24 s | Biến quái thành sôcôla |
| 7 | Khiên năng lượng (19) | như trên | 15 → 45 | 51% → 33% | 75 → 105 s | Vô hiệu đòn |
| 8 | Ma phong ba (26) | 60 tỷ | 550 → 1.000 | 80% → 35% | 170 → 80 s | Nhốt đối thủ vào bình |

### 3.3 Xayda (gender 2)

| Ô | Skill (id) | Sức mạnh mở | Dame | Mana | Hồi chiêu | Tác dụng |
|---|---|---|---|---|---|---|
| 0 | Chiêu đấm Galick (4) | 1.000 → 1,8 triệu | 110 → 170 | 1 → 70 | 0,5 s | Đấm thường |
| 1 | Antomic (5) | 10.000 → 4,8 triệu | 110 → 290 | 18 → 1.026 | 1 → 2,2 s | Chưởng tầm xa |
| 2 | Tái tạo năng lượng (8) | 60.000 → 30 triệu | hồi 4 → 10%/s | 0 | 55 → 25 s | Tự hồi HP và KI |
| 3 | Biến hình (13) | 250 → 850 triệu | tăng sức đánh, HP, tốc độ | 10% | 300 → 360 s | Hoá khỉ |
| 4 | Tự phát nổ (14) | 250 → 550 triệu | 100 → 130 | 50% | 120 s | Hy sinh gây sát thương lớn |
| 5 | Huýt sáo (21) | 10 triệu → 15,6 tỷ | +40 → +100% HP đồng đội | 50 → 20 | 210 → 180 s | Tăng HP đội, +1 đòn chí mạng |
| 6 | Trói (23) | 10 triệu → 15,6 tỷ | 5 → 35 | 5.000 → 32.000 | 15 → 45 s | Trói kẻ địch |
| 7 | Khiên năng lượng (19) | như trên | 15 → 45 | 51% → 33% | 75 → 105 s | Vô hiệu đòn |
| 8 | Cađíc liên hoàn chưởng (25) | 60 tỷ | 550 → 1.000 | 80% → 35% | 170 → 80 s | Đại chiêu, 10 cấp |

**Điểm đáng chú ý:**
- Khiên năng lượng (id 19) là **một skill dùng chung** cho cả 3 hành tinh.
- Cấp 1–7 của skill mở theo sức mạnh. Ví dụ đấm Dragon: 1.000 / 10.000 / 22.000 / 66.000 / 200.000 / 600.000 / 1,8 triệu. Cột `info` ghi nơi học: "ông nội" (cấp 1–2) và "Quy Lão Kame" (cấp 3 trở lên). Tôi chỉ đọc đủ cho Trái Đất.
- Cột `price` (0 → 9.999) tồn tại, đơn vị chưa xác minh.
- Công thức sát thương thật, tiêu hao KI chi tiết, hiệu ứng phụ nằm trong `SkillService`: **CHƯA KIỂM TRA**.

**Ràng buộc kỹ thuật:**
- Dữ liệu skill: bảng `skill_template`, cột `skills` là JSON nhiều cấp. Số liệu đổi được trong DB.
- Hành vi skill (choáng, hồi, nổ, biến hình, ...) là **code Java gắn theo skill id**. Đổi hành vi nghĩa là sửa `SkillService`.
- Hoạt ảnh/hiệu ứng của skill do client tra theo skill id: **CHƯA KIỂM TRA** trong Unity.

---

## 4. Nội tại (intrinsic)

**Nguồn:** bảng `intrinsic`, 208 dòng (ĐÃ ĐỌC). Phần cách mở, phí, đổi: **CHƯA KIỂM TRA**.

| gender | Số dòng | Nội dung |
|---|---|---|
| 0 Trái Đất | 56 | Buff theo từng skill: đấm Dragon, Kamejoko, Thái Dương Hạ San, Quả cầu kênh khí, Khiên, Dịch chuyển, Thôi miên (+x% đến y% sát thương hoặc tốc độ hồi chiêu), mỗi skill lặp 8 lần với khoảng giá trị tăng dần |
| 1 Namếc | 64 | Tương tự cho đấm Demon, Masenko, Trị thương, Makankosappo, Đẻ trứng, Liên hoàn, Sôcôla, Khiên |
| 2 Xayda | 56 | Tương tự cho Galick, Antomic, Biến hình, Tự phát nổ, Khiên, Huýt sáo, Trói |
| 3 Chung | 32 | "Chưa kích hoạt nội tại", vàng rơi từ quái +x%, sức mạnh và tiềm năng khi đánh quái +x%, chí mạng liên tục khi HP dưới x% |

Nội tại bám theo **tên skill**. Đổi bộ skill hành tinh thì phải viết lại nội tại tương ứng.

---

## 5. Nhiệm vụ chính

**Nguồn:** `task_main_template` (30 dòng, id 0–29) và `task_sub_template` (125 bước) (ĐÃ ĐỌC).

**Quy ước cột:** NPC `-1` = không có; `-2` = nhà người nuôi; `-5` = sư phụ. Map `-1` = bất kỳ.

### 5.1 Toàn bộ nhiệm vụ

| NV | Tên (DB) | Các bước (số lượng, NPC/map nếu có) |
|---|---|---|
| 0 | Nhiệm vụ đầu tiên | Đi tới mũi tên → vào nhà %2 → nói chuyện %2 → mở rương (NPC 3) → thu đậu thần (NPC 4) → báo cáo %2 |
| 1 | Tập luyện | Đánh ngã 5 mộc nhân → báo cáo %2 |
| 2 | Tìm thức ăn | Nhặt 10 đùi gà → báo cáo %2 |
| 3 | Sao băng | Dùng tiềm năng → khám phá vật thể lạ (map -4) → báo cáo %2 |
| 4 | Thử thách | 3 khủng long mẹ → 3 lợn lòi mẹ → 3 quỷ đất mẹ → báo cáo %2 |
| 5 | Thử thách | Như NV 4, đổi thứ tự: lợn lòi mẹ, khủng long mẹ, quỷ đất mẹ |
| 6 | Thử thách | Như NV 4, thứ tự: quỷ đất mẹ, khủng long mẹ, lợn lòi mẹ |
| 7 | Giải cứu | Đạt 16.000 SM → 20 %9 → nói chuyện %8 → báo cáo %2 |
| 8 | Tìm ngọc | Đạt 40.000 SM → tìm ngọc rồng 7 sao → đem về %2 |
| 9 | Bái sư | Lên đường → chào %10 |
| 10 | Thử sức | Đạt 200k SM → diệt 10 %12 → báo cáo %10 |
| 11 | Gia tăng sức mạnh | Đạt 500k (NPC 54, map 5) → 550k → 600k → về nhà %2 (NPC 105, map 42) |
| 12 | Xin phép | Về nhà %2 → xin phép gia nhập bang hội → báo %10 |
| 13 | Gia nhập bang hội | Tạo/gia nhập bang có 2 thành viên (NPC 13, map 5) → báo %10 |
| 14 | Bang hội đầu tiên | 30 heo rừng (map 27) → 30 heo da xanh (map 31) → 30 heo Xayda (map 35) → báo %10 |
| 15 | Bang hội thứ 2 | 30 bulon (map 30) → 30 ukulele (map 34) → 30 quỷ mập (map 38) → báo %10 |
| 16 | Tiêu diệt quái vật | Tambourine (map 6) → Drum (map 10) → Akkuman (map 19) → báo %10 |
| 17 | Giúp đỡ Cui | Tới Thành phố Vegeta (map 19) → nói chuyện Cui (NPC 12) |
| 18 | Bất khả thi | 500 Nappa → 400 Soldier → 300 Appule → 200 Raspberry → 100 Thằn lằn xanh → báo %10 |
| 19 | Tìm diệt đệ tử | Kuku → Mập đầu đinh → Rambo → báo %10 |
| 20 | Tiểu đội sát thủ | Đạt 600 triệu → Số 4 → Số 3 → Số 2 → Số 1 → Tiểu Đội Trưởng → báo %10 |
| 21 | Chạm trán Fide | Đạt 2 tỷ → Fide cấp 1 → 2 → 3 → báo %10 |
| 22 | Chú bé từ tương lai | Báo %2 → tìm khách lạ (NPC 38) → đưa thuốc cho Quy Lão (NPC 13, map 5) → gặp Bunma tương lai (NPC 37, map 102) → 1.000 xên con cấp 1 → báo Bunma TL |
| 23 | Robot sát thủ 1 | Tới map 97 → Android 19 → Android 20 → 900 xên con cấp 3 → báo Bunma TL |
| 24 | Robot sát thủ 2 | Tới sân sau siêu thị (map 104) → Android 15 → 14 → 13 → báo Bunma TL |
| 25 | Robot sát thủ 3 | Tìm Píc Póc → Póc → Píc → Kinh Kong → 800 xên con cấp 5 → báo Bunma TL |
| 26 | Xên bọ hung | Tới thị trấn Ginder → Xên bọ hung cấp 1 → cấp 2 → hoàn thiện → 700 xên con cấp 8 → báo Bunma TL |
| 27 | Cuộc dạo chơi của Xên | Nâng sức đánh gốc 10K (hoặc 35K, xem mục 0) → 50 Capsule kì bí → tới võ đài Xên bọ hung → 7 con của Xên → Siêu Bọ Hung → báo Bunma TL |
| 28 | Đối đầu không cân sức | Đi theo Ôsin (NPC 44) → mỗi boss 10 con: Drabura, Pui Pui, Pui Pui lần 2, Yacôn, Drabura lần 2, Mabư → báo Ôsin. Mô tả nói "12h trưa hằng ngày", map Đại hội võ thuật |
| 29 | Hết | "Bạn đã xong nhiệm vụ rồi" |

Tổng: 30 nhiệm vụ (id 0–29), 125 bước.

### 5.2 Thưởng thật trong code
**Nguồn:** `TaskService.rewardDoneTask`, dòng 1085–1100 (ĐÃ ĐỌC).

| NV | Sức mạnh + tiềm năng (mỗi loại) | Ghi chú |
|---|---|---|
| 0 | 500 | |
| 1 | 1.000 | |
| 2 | 1.200 | |
| 3 | 3.000 | |
| 4 | 7.000 | |
| 5 | 20.000 | |
| 6 trở đi | **không có case riêng** | |

Thêm cho NV id 1–24, trong `if (id > 0 && id < 25)`:
- Thêm `addSMTN(type 2, 500 × (id + 1))`. Loại 2 là loại SMTN gì thì chưa đọc.
- Vàng: `100.000 × (id + 1)` với id 1–4, và `500.000` với id 5–24.

Hệ quả: **NV 25–29 không có thưởng khi hoàn thành.** Các dòng "Thưởng 4.000 sức mạnh", "Thưởng 50.000.000 sức mạnh" trong `NHIEM_VU.md` là chữ mô tả trong DB, **không khớp** số trong code. Tôi chưa tìm nơi code cấp thưởng NV 7–24 theo mô tả đó, có thể là `addSMTN` kiểu khác. **CHƯA KIỂM TRA**.

### 5.3 Cơ chế (ĐÃ ĐỌC một phần)
- Hằng số `ConstTask` có **6.338 dòng `public static final`**. Logic kiểm tra bước nhiệm vụ viết theo taskId/index gắn cứng.
- Chuỗi tên nhiệm vụ dùng `%1..%14`, `TaskService` thay theo gender (mục 1).
- `transformMapId`: `MAP_NHA` = `gender + 21`; `MAP_200` = map 1 / 8 / 15 theo hành tinh.
- Hoàn thành bước: `addDoneSubTask` tăng `count`; đủ `maxCount` thì sang bước tiếp, hết bước thì `sendNextTaskMain`.
- Client gắn cứng theo `taskId` (ví dụ ≤ 14): **CHƯA KIỂM TRA lại trong lần này**. Theo ghi chú từ phiên trước, có chỗ ở `XmapData` (mốc ≤ 14, ≥ 14, > 30) nên NV 0–15 không nên đánh số lại.

### 5.4 Mạch cốt truyện gốc

| Chặng | NV | Nội dung | Khoảng sức mạnh |
|---|---|---|---|
| Làng | 0–6 | Ở nhà, tập luyện, học bay, sao băng, đánh quái mẹ 3 hành tinh | 2.000 → ~20.000 |
| Tìm sư phụ | 7–13 | Cứu dân, tìm ngọc 7 sao, bái sư, vào bang hội | 16.000 → 600.000 |
| Đi nhóm | 14–17 | Diệt quái theo cụm, Tambourine/Drum/Akkuman, gặp Cui | ~600k → |
| Fide | 18–21 | Lính Fide, đệ tử, tiểu đội sát thủ, Fide | 50 triệu → 2 tỷ |
| Tương lai | 22–26 | Android 19/20/13/14/15, Píc Póc Kinh Kong, Xên | |
| Kết | 27–28 | Siêu Bọ Hung, Đại hội võ thuật (Drabura, Pui Pui, Yacôn, Mabư) | |

---

## 6. Nhiệm vụ phụ, bang hội, danh hiệu, thành tựu

Nguồn: DB (ĐÃ ĐỌC). Cách giao, thưởng, giới hạn lượt: **CHƯA KIỂM TRA** (ngoài phần thưởng vàng của nhiệm vụ phụ ở `TaskService` dòng ~1334).

| Loại | Bảng | Số lượng | Cấu trúc |
|---|---|---|---|
| Nhiệm vụ phụ hằng ngày | `side_task_template` | 59 loại | Mỗi loại có 5 cấp. Ví dụ id 0 "Tiêu diệt khủng long": cấp 1 = 1–20 con, cấp 5 = 2.000–5.000. Id 24 "tambourine": cấp 1 = 1–5, cấp 5 = 500–1.000. Id 58 "Nhặt vàng": 1.000–3.000 lên 10 triệu–100 triệu |
| Nhiệm vụ bang hội | `clan_task_template` | 59 loại | Cùng danh sách và dải số lượng như nhiệm vụ phụ, đổi "Tiêu diệt" thành "Hạ" |
| Nhiệm vụ danh hiệu | `task_badges_template` | 18 loại | Xem bên dưới |
| Thành tựu | `achievement_template` | 20 | Ví dụ: Gia nhập Vệ Binh (340.000 SM), Sức mạnh siêu cấp (1,5 triệu), Nông dân chăm chỉ (5), Đạt 15 triệu sức mạnh. Cột `money` là thưởng |

**Nhiệm vụ danh hiệu (18):**
- 3 loại nạp tiền: tích luỹ 1 triệu/ngày, 2 triệu/ngày (id 1 và 16).
- Ước Rồng Thần 1 sao ×100 (id 2).
- Hạ Cumber/Black Goku/Cooler/Xên 300 lần (id 3).
- Đập 5 trang bị +7 (id 4).
- Top 1 võ đài siêu hạng (id 5).
- Nhiệm vụ siêu khó tại Bò Mộng ×10 (id 6).
- Xương sói (id 7), Xinbato (id 8).
- Nhặt đồ 500 lần (id 9).
- 30 Boss ăn trộm (id 10), 30 Boss ở dơ (id 11).
- Mở rương gỗ cấp 12 (id 12–14).
- 500 điểm sự kiện (id 15).
- Sở hữu 7 rồng nhí (id 17).
- Fan cứng KOL (id 18).

Nhiều loại là nạp tiền hoặc sự kiện riêng của server này, không thuộc cốt truyện.

---

## 7. Bang hội

**Nguồn:** `Clan.java`, `ClanService.java` (chỉ đọc đầu file, ĐÃ ĐỌC một phần).

| Mục | Nội dung |
|---|---|
| Thành viên tối đa mặc định | 10 (`maxMember = 10`), cấp bang khởi đầu 1 |
| Chức vụ | Bang chủ (`LEADER`), Phó (`DEPUTY`), Thành viên |
| Tạo bang | Chọn cờ (`imgId`), tên. Phí theo `FlagBag` (có thể tốn vàng và/hoặc ngọc, tuỳ cờ) |
| Dữ liệu bang | slogan, `capsuleClan`, tiến độ phó bản: `levelDoneBanDoKhoBau`, `levelDoneCDRD` (Con đường rắn độc), `levelDoneKhiGas` |
| Chia kinh nghiệm | Chia theo chênh lệch cấp bậc giữa hai người (`Clan.java` dòng 148–151) |
| NPC liên quan | NPC 13 (nhiệm vụ gia nhập), NPC 47 `SHOP_CLAN`, nhiệm vụ bang hội (mục 6) |

**CHƯA KIỂM TRA:**
- Giá tạo bang cụ thể.
- Cách tăng số thành viên và cấp bang.
- Quyền hạn từng chức vụ.
- Cơ chế xin/cho đậu thần.
- Kiểm tra "cùng 2 đồng bang" ở NV 23/25/26 có thật sự đòi hỏi trong code hay không.

**Phó bản nhóm tìm thấy trong code:** Doanh trại độc nhãn (map 53–62 và boss `doanh_trai`), Khí gas (`khi_gas`), Bản đồ kho báu (map 135–138, `ban_do_kho_bau`), Con đường rắn độc (map 141–143), Thành cổ (map 183–185). Điều kiện vào, thưởng, giới hạn lượt: **CHƯA KIỂM TRA**.

---

## 8. Ngọc rồng và ước rồng

**Nguồn:** `SummonDragon.java`, `SummonDragonNamek.java` (ĐÃ ĐỌC).

**Ngọc rồng:** item id 14 (1 sao) → 20 (7 sao).

### 8.1 Rồng Thần Trái Đất (Shenron)
- Chỉ gọi được **ở làng trước nhà** (map 0, 7, 14 tuỳ hành tinh).
- 3 cách gọi: ngọc 1 sao (cần đủ 1–7 sao), ngọc 2 sao (cần 2–7 sao), ngọc 3 sao (cần 3–7 sao). Ngọc 4–7 sao không gọi được rồng.
- Có 5 phút để chọn ước. Quá 5 phút rồng bay mất. **Ngọc mất ngay khi gọi**, dù có ước hay không.

| Rồng | Điều ước |
|---|---|
| 3 sao | +200 ngọc, +2 triệu sức mạnh và tiềm năng, +20 triệu vàng (theo mảng `SHENRON_3_STARS_…`) |
| 2 sao | +2K ngọc, +20 triệu sức mạnh và tiềm năng, +200 triệu vàng (theo mảng `SHENRON_2_STARS_…`) |
| 1 sao, trang 1 | +2 tỷ vàng ("+2 Tỏi"), găng tay đang mang lên 1 cấp, chí mạng gốc +2%, thay chiêu 2–3 của đệ tử, "điều ước khác" |
| 1 sao, trang 2 | Đẹp trai nhất vũ trụ, +10K ngọc, +200 triệu sức mạnh và tiềm năng, găng tay đệ tử lên 1 cấp, "điều ước khác" |
| 1 sao, trang 3 | Quần đang mang lên 1 cấp, quần đệ tử lên 1 cấp |

**Lệch trong chính code:** đoạn tutorial (`SUMMON_SHENRON_TUTORIAL`) nói rồng 3 sao cho "200k vàng", rồng 2 sao cho "2 triệu vàng", rồng 1 sao cho "20 triệu vàng", còn menu ước hiển thị 20 triệu / 200 triệu vàng như bảng trên. Số thật nằm ở đoạn xử lý (dòng ~293, 437, 456 của `SummonDragon.java`), tôi **chưa đọc**. Cần đọc trước khi tin con số nào.

### 8.2 Rồng Thần Namếc
- Ban điều ước cho **cả bang hội**, 5 phút để chọn.
- Ước: 1–20 viên ngọc rồng 3 sao, "pet hổ sẽ béo", 99 bột mì.

### 8.3 Rồng khác trong NPC
Template NPC có: Rồng Thiêng (24), Rồng Thần Namec (27), Rồng Omega (29), Rồng 1–7 sao (30–36).

**CHƯA KIỂM TRA:** Rồng Omega, vị trí ngọc tản ra sau khi gọi, ngọc rồng đen, cách rơi ngọc, radar dò ngọc. NV8 "tìm ngọc 7 sao" là bước nhiệm vụ riêng, cách nó cấp ngọc chưa đọc.

---

## 9. Thế giới: bản đồ, quái, NPC

**Nguồn:** `map_template` (169 dòng), `mob_template` (119), `npc_template` (93) (ĐÃ ĐỌC).

### 9.1 Bản đồ
Mỗi map có 10 khu (zone). Cột `planet_id` chia 3 vùng.

| Vùng (`planet_id`) | Số map | Nội dung chính |
|---|---|---|
| 0 | 51 | Trái Đất và thế giới thần: Làng Aru (0), Đồi hoa cúc, Thung lũng tre, Rừng nấm, Rừng xương, Đảo Kamê (5), Thần điện (45), Tháp Karin (46), Hành tinh Kaio (48), Phòng tập thời gian (49), Thánh địa Kaio, Tầng 1–4, Tường thành 2–3, Trại độc nhãn 1–3, Lãnh địa Fize (78), Siêu thị (84), Bụng Mabư (128), Động hải tặc/Hang bạch tuộc/Động kho báu/Cảng hải tặc (135–138), Con đường rắn độc (141–143), Hành tinh Bill (154), Hành tinh ngục tù (155), Thành cổ (183–185) |
| 1 | 21 | Namếc: Làng Mori (7), Đồi nấm tím, Thị trấn Moori, Thung lũng Namếc, Maima, Đảo Guru (13), Núi hoa vàng/tím, Nam/Đông Nam Guru, và 6 map không tên (95, 101, 121, 125, 130, 134) |
| 2 | 97 | Xayda và vũ trụ: Làng Kakarot (14), Đồi hoang, Làng Plant, Thành phố Vegeta (19), Vách núi đen (20), Rừng cọ/đá, Đấu trường (51), Đại hội võ thuật (52, 113, 129), Trại lính Fide, các map Nappa/Appule/Raspberry, Khỉ đỏ/vàng/đen, các hành tinh (M-2, Polaris, Cretaceous, Monmaasu, Rudeeze, Gelbo, Tigere, Yardart, Potaufeu), tương lai (92–100 Thành phố, Cao nguyên, Ginder), Nhà Bunma (102), Võ đài Xên bọ hung (103), tuyết/băng (105–110), Võ đài Hạt Mít (112), Cổng phi thuyền, Cửa ải, Ngũ Hành Sơn, Santa, Lychee, Myuu... |

- Mỗi hành tinh có nhà (map 21/22/23), trạm tàu vũ trụ (map 24/25/26) và vách núi (39–44).
- Map xuất hiện của người chơi mới: 39/40/41 (mục 1).
- Cột `type`: 116 map loại 0, còn lại 1–9 (ý nghĩa **CHƯA KIỂM TRA**).
- Quái, NPC, waypoint của từng map nằm trong các cột `mobs`, `npcs`, `waypoints` (dữ liệu kiểu mảng).

### 9.2 Quái (`mob_template`)
HP tăng dần theo vùng sức mạnh:

| Nhóm | HP |
|---|---|
| Mộc nhân | 20 |
| Khủng long/lợn lòi/quỷ đất | 200 |
| Bản "mẹ" (id 4–6) | 500 |
| Quái bay (id 7–9) | 600 |
| Thằn lằn/phi long/quỷ bay mẹ (id 10–12) | 1.000 |
| Ốc mượn hồn, ốc sên, heo Xayda mẹ (id 13–15) | 3.000 |
| Heo rừng (id 16–18) | 1.500 |
| Bulon/Ukulele/Quỷ mập | 6.000 |
| Tambourine/Drum/Akkuman | 20.000 |
| Nappa → Quỷ chim (id 39–50) | 40.000 → 180.000 |
| Khỉ lông đen → vàng (id 54–57) | 300.000 → 450.000 |
| Xên con cấp 1 → 8 (id 58–65) | 200.000 → 550.000 |
| Siêu quái (Hirudegarn 40 triệu, Cỗ máy hủy diệt 80 triệu, Gấu tướng cướp 2 tỷ, Piano 2 tỷ, Máy đo sức mạnh 2 tỷ) | |

Cột `percent_dame` và `percent_tiem_nang` quyết định sát thương và tiềm năng quái cho. Công thức **CHƯA KIỂM TRA**.

### 9.3 NPC (`npc_template`)
Nhóm chức năng nhìn từ tên và file `npc_list`:

| Nhóm | NPC |
|---|---|
| Người nuôi | Ông Gôhan (0), Ông Paragus (1), Ông Moori (2) |
| Cửa hàng làng | Bunma (7), Dende (8), Appule (9) |
| Trạm tàu | Dr. Brief (10), Cargo (11), Cui (12) |
| Sư phụ | Quy Lão Kame (13), Trưởng lão Guru (14), Vua Vegeta (15) |
| Thế giới thần | Thần mèo Karin (18), Thượng Đế (19), Thần Vũ Trụ (20), Tổ Sư Kaio (43), Kibit (45), Bill (55), Whis (56), Champa (57), Vados (58) |
| Đại hội võ thuật | Bà Hạt Mít (21), Trọng tài, Ghi danh (23), Ôsin (44) |
| Chức năng | Rương đồ (3), Đậu thần (4), Cửa hàng ký gửi (28), Quốc Vương (42), Bò Mộng (17) |
| Tương lai | Bunma tương lai (37), Ca Lích (38) |
| Khác | Santa (39), Mabư mập (40), Mr Popo (67), Bardock (70), Fide (73), Granola (76), Dr. Myuu (83) |
| Sự kiện | Trung thu, Hùng Vương, Noel, Tết, Bí Ngô... |

Chức năng chi tiết từng NPC trong menu: **CHƯA KIỂM TRA**.

**Ràng buộc kỹ thuật:**
- Map, mob, NPC là dữ liệu DB. Đổi tên và đặt lại vị trí là dữ liệu.
- Hình map, mob, NPC nằm trong client Unity, tham chiếu bằng id. Muốn đổi hình phải đổi asset client.
- Theo ghi chú phiên trước: client cache tên map/NPC/mob qua `DataGame.vsMap` và item qua `vsItem`. Khi đổi tên phải tăng số version đó.
- Theo ghi chú phiên trước: client chỉ đọc được part < 2.000, NPC/vật phẩm dùng part ≥ 2.000 sẽ làm client lỗi.

---

## 10. Vật phẩm, trang bị, nâng cấp, cửa hàng

### 10.1 Vật phẩm (`item_template`, 2.000 dòng, ĐÃ ĐỌC)
- Cột: `TYPE`, `gender` (0/1/2 là theo hành tinh, **3 = dùng chung**), `level`, `icon_id`, `part`, `power_require`, `gold`, `gem`, `head/body/leg`.
- Đếm theo `gender`: gender 3 = 1.455, gender 0 = 183, gender 1 = 180, gender 2 = 182.
- Đếm theo `TYPE` (ý nghĩa từng type **CHƯA KIỂM TRA**): 0 = 45, 1 = 48, 2 = 45, 3 = 45, 4 = 17, 5 = 457, 6 = 11, 7 = 154, 8 = 3, 9 = 4, 10 = 1, 11 = 190, 12 = 28, 13 = 14, 14 = 5, 15 = 1, 16 = 1, 17 = 3, 22 = 4, 23 = 50, 24 = 5, 25 = 7, 27 = 503, 28 = 14, 29 = 77, 30 = 25, 31 = 9, 32 = 8, 33 = 21, 34 = 1, 36 = 21, 37 = 25, 75 = 158.
- Suy luận: type 0–4 là áo, quần, găng, giày, rada (hợp với bộ khởi đầu id 0/1/2 và 6/7/8 và rada id 12). **SUY LUẬN**, chưa xác minh trong code.
- Option: `item_option_template` có 251 option (chỉ số HP, KI, sức đánh, giáp, chí mạng...). Danh sách và cách tính **CHƯA KIỂM TRA**.

### 10.2 Nâng cấp (package `combine`)
Các loại tìm thấy theo tên class (ĐÃ ĐỌC tên; công thức, giá, tỉ lệ **CHƯA KIỂM TRA**):
- Nâng cấp vật phẩm (`NangCapVatPham`).
- Ép sao trang bị (`EpSaoTrangBi`).
- Pha lê hoá (`PhaLeHoaTrangBi`, `NangCapSaoPhaLe`, `CuongHoaLoSaoPhaLe`, `DanhBongSaoPhaLe`).
- Chuyển hoá trang bị bằng ngọc/vàng (`ChuyenHoaTrangBi_Ngoc`, `ChuyenHoaTrangBi_Vang`).
- Nhập ngọc rồng (`NhapNgocRong`).
- Làm phép nhập đá (`LamPhepNhapDa`), đá Hematite, đá mài.
- Bông tai (`NangCapBongTai`, `NangCapBongTai3`, `NangChiSoBongTai`...).
- Sách tuyệt kỹ (`HocTuyetKy`, `NangCapSachTuyetKy`, `TaySach`, `PhanRaSach`...).
- Chế tạo trang bị Thiên Sứ, phân rã trang bị kích hoạt, tái tạo capsule kích hoạt.

### 10.3 Cửa hàng (`shop`, 32 dòng; `tab_shop`, 58 dòng)
Danh sách shop và NPC bán, từ bảng `shop`:
- Bunma/Dende/Appule (làng), Uron.
- Santa: nhiều tab (đầu, rương, hạn sử dụng, giảm giá, danh hiệu, mở rộng hành trang).
- Bùa 1h/8h/1 tháng (NPC 21).
- Bunma tương lai, Bill, Ôsin, Karin.
- Thiên sứ, Quy Lão (`QUY_LAO`, `QDDN`, `SHOP_DOI_DIEM`).
- Đổi skill đệ tử (NPC 75), shop VIP, shop bang hội (NPC 47), shop sự kiện.

Hàng bán từng shop (`item_shop`) và giá: **CHƯA KIỂM TRA**.

---

## 11. Đệ tử, hợp thể, thành phần khác

| Hệ thống | Điều đã đọc | Ghi chú |
|---|---|---|
| Đệ tử (Pet) | 5 trạng thái: đi theo, bảo vệ, tấn công, về nhà, hợp thể. `PetService` có các loại tạo: thường, Mabư, Uub, Kid Bư, Jiren. Có `limitPower` riêng | Chỉ số khởi đầu, công thức tăng, cách nhận: **CHƯA KIỂM TRA** |
| Hợp thể | `Fusion.java`: Lưỡng long nhất thể (hằng số 4), Hợp thể Porata (6, 8, 9). Thời gian hợp 600.000 ms (10 phút) | Điều kiện, chỉ số khi hợp: **CHƯA KIỂM TRA** |
| Boss | Thư mục `boss/` có ~30 nhóm: Frieza, Cold, Cell, Android, Black_Goku, Broly, Cumber, Baby, MajinBuu 12h/14h, Nappa, Golden Fide, nhân bản, Yardrat, tiểu đội sát thủ, Boss mini, Ma vương Picolo... | HP, skill, giờ xuất hiện, drop: **CHƯA KIỂM TRA** |
| Giải đấu | `dai_hoi_vo_thuat`, `sieu_hang` (bảng `super_rank`: 1.346 dòng), `vo_dai_hat_mit` | Quy tắc, phí, thưởng: **CHƯA KIỂM TRA** |
| Radar | Bảng `radar`, 21 thẻ sưu tầm quái (khủng long, lợn lòi, quỷ đất, thằn lằn bay, phi long, Oozaru...) | Cơ chế: **CHƯA KIỂM TRA** |
| Danh hiệu/huy hiệu | Bảng `data_badges` (16 dòng) gắn với nhiệm vụ danh hiệu | Chỉ số cộng thêm: **CHƯA KIỂM TRA** |
| Sự kiện theo mùa | Boss và NPC Tết, Trung thu, Noel, Hùng Vương, Halloween | Không cần cho game mới |
| Tính năng server riêng | Nạp thẻ, VIP, ngân hàng, giftcode, bài đăng, bình luận (các bảng `napthe`, `payments`, `bank_transfers`, `giftcode`, `posts`, `comments`, `adminpanel`) | Là phần của server cộng đồng, không phải game gốc |

---

## 12. Những gì CHƯA kiểm tra (làm tiếp khi cần)

Phiên này đã chạy 11 agent song song để đọc sâu từng mảng, nhưng **tất cả dừng giữa chừng vì hết hạn mức** (reset 3:10 sáng) và chưa agent nào ghi kết quả. File này do tôi viết trực tiếp từ DB và các đoạn code đọc ở trên.

Đọc tiếp theo thứ tự ưu tiên:
1. **`NPoint.java`**: công thức HP/KI/sức đánh/giáp/chí mạng, giá cộng tiềm năng, kinh nghiệm khi đánh quái.
2. **`SkillService.java`**: công thức sát thương và tiêu KI của từng skill, nhất là Makankosappo, Tự phát nổ, Quả cầu kênh khí.
3. **Client Unity (`PROJECT_NRO_240`)**: gắn cứng `taskId`, danh sách skill, hình hoạt ảnh skill, màn tạo nhân vật.
4. Đệ tử (`PetService`, `Pet`): chỉ số, cách nhận, nâng cấp.
5. Boss và phó bản: HP, giờ xuất hiện, thưởng.
6. Bang hội đầy đủ: giá, cấp, quyền hạn.
7. Combine: nguyên liệu, tỉ lệ, trần cấp.
8. Shop (`item_shop`) và drop.
9. Phần thưởng nhiệm vụ NV 6–24 (mục 5.2): tìm đúng nơi code cấp thưởng.

---

## 13. Việc cần quyết định trước khi làm One Piece

Đây là các điểm kỹ thuật, không phải đề xuất thiết kế.

1. **Số phe.** Game gốc có đúng 3 hành tinh (gender 0/1/2). Thêm phe thứ 4 phải tách "phe" khỏi "gender" và sửa màn tạo nhân vật của client.
2. **Số nhiệm vụ.** Gốc có 29 nhiệm vụ cốt truyện (0–28) cộng nhiệm vụ "hết" (29). Client có điểm so sánh `taskId` cố định, nên NV 0–15 giữ nguyên id.
3. **Bộ skill.** Muốn đổi tên, số liệu: chỉ sửa DB. Muốn đổi **hành vi**: sửa Java. Nội tại bám theo tên skill nên phải viết lại cùng lúc.
4. **Rồng thần.** Dữ liệu ước nằm trong code (`SummonDragon`), không nằm DB. Đổi ước hoặc đổi tên "Rồng thần/ngọc rồng" là sửa code và item.
5. **Đơn vị hiển thị.** "Sức mạnh", "tiềm năng", "vàng" là chữ hiển thị. Phần client có thể gắn cứng một số chuỗi: **CHƯA KIỂM TRA**.
6. **DB.** Dùng lại `database team2026.sql` làm gốc sạch, rồi áp bản sửa lên. DB live hiện đang lẫn dữ liệu bản cũ (mục 0).
