# Toàn bộ nhiệm vụ trong game (trích từ `database team2026.sql`)

Ký hiệu `%1..%14` là placeholder, server thay bằng tên NPC/map/quái/số lượng tuỳ hành tinh của người chơi.

## 1. Nhiệm vụ chính (task_main_template + task_sub_template)

### Nhiệm vụ 0: Nhiệm vụ đầu tiên

Chi tiết nhiệm vụ

Các bước:

1. Di chuyển tới mũi tên chỉ dẫn
2. Hãy đi đến nhà %2 ở bên phải
3. Nói chuyện với %2
4. Mở rương đồ
5. Thu hoạch đậu thần
6. Báo cáo với %2

### Nhiệm vụ 1: Nhiệm vụ tập luyện

Mộc nhân được đặt nhiều tại %1, ngay trước nhà %2  
Hãy đánh ngã 5 mộc nhân,   
sau đó quay về nhà báo cáo với ông %2  
Để đánh, hãy chạm nhanh 2 lần vào đối tượng  
Thưởng 1000 sức mạnh  
Thưởng 1000 tiềm năng  
Thưởng 200tr vàng

Các bước:

1. Đánh ngã 5 mộc nhân (x5)
2. Báo cáo với %2

### Nhiệm vụ 2: Nhiệm vụ tìm thức ăn

Tìm đến %3, tiêu diệt bọn quái %4 và nhặt về 10 đùi gà  
Thưởng 1500 sức mạnh  
Thưởng 1500 tiềm năng  
Thưởng 300tr vàng  
Học được kỹ năng bay

Các bước:

1. Thu thập 10 đùi gà (x10)
2. Báo cáo với %2

### Nhiệm vụ 3: Nhiệm vụ sao băng

Đi khám phá xem vật thể lạ vừa rơi xuống hành tinh  
Thưởng 2000 sức mạnh  
Thưởng 2000 tiềm năng  
Thưởng 400tr vàng

Các bước:

1. Sử dụng tiềm năng
2. Đi khám phá vật thể lạ
3. Báo cáo với %2

### Nhiệm vụ 4: Nhiệm vụ thử thách

Khủng long mẹ sống tại Trái Đất  
Lợn lòi mẹ sống tại Namếc  
Quỷ đất mẹ sống tại Xayda  
Dùng tàu vũ trụ để di chuyển sang hành  
khác  
-Thưởng 4.000 sức mạnh  
-Thưởng 4.000 tiềm năng

Các bước:

1. Đánh 3 con khủng long mẹ (x3)
2. Đánh 3 con lợn lòi mẹ (x3)
3. Đánh 3 con quỷ đất mẹ (x3)
4. Báo cáo với %2

### Nhiệm vụ 5: Nhiệm vụ thử thách

Lợn lòi mẹ sống tại Namếc  
Khủng long mẹ sống tại Trái Đất  
Quỷ đất mẹ sống tại Xayda  
Dùng tàu vũ trụ để di chuyển sang hành  
khác  
-Thưởng 4.000 sức mạnh  
-Thưởng 4.000 tiềm năng

Các bước:

1. Đánh 3 con lợn lòi mẹ (x3)
2. Đánh 3 con khủng long mẹ (x3)
3. Đánh 3 con quỷ đất mẹ (x3)
4. Báo cáo với %2

### Nhiệm vụ 6: Nhiệm vụ thử thách

Quỷ đất mẹ sống tại Xayda  
Khủng long mẹ sống tại Trái Đất  
Lợn lòi mẹ sống tại Namếc  
Dùng tàu vũ trụ để di chuyển sang hành  
khác  
-Thưởng 4.000 sức mạnh  
-Thưởng 4.000 tiềm năng

Các bước:

1. Đánh 3 con quỷ đất mẹ (x3)
2. Đánh 3 con khủng long mẹ (x3)
3. Đánh 3 con lợn lòi mẹ (x3)
4. Báo cáo với %2

### Nhiệm vụ 7: Nhiệm vụ giải cứu

Đến khu vực %13,  
Hạ 20 con %9  
- Thưởng 8.000 sức mạnh  
- Thưởng 8.000 tiềm năng

Các bước:

1. Đạt 16.000 sức mạnh
2. Đánh bại 20 con %9 (x20)
3. Nói chuyện với %8
4. Báo cáo với %2

### Nhiệm vụ 8: Nhiệm vụ tìm ngọc

Ngọc rồng 7 sao đang bị bọn  
%14 cướp đi.  
Đánh bại chúng để tìm lại.  
- Thưởng 15.000 sức mạnh  
- Thưởng 15.000 tiềm năng

Các bước:

1. Đạt 40.000 sức mạnh
2. Tìm viên ngọc rồng 7 sao
3. Đem ngọc về cho %2

### Nhiệm vụ 9: Nhiệm vụ bái sư

Tìm đường tới %11, trò chuyện với %10 và xin làm đệ tử

Các bước:

1. Lên đường
2. Chào hỏi %10

### Nhiệm vụ 10: Nhiệm vụ thử sức

Tiêu diệt %12 thể hiện sức mạnh cho %10 thấy

Các bước:

1. Đạt 200k sức mạnh
2. Diệt 10 con %12 (x10)
3. Báo cáo với %10

### Nhiệm vụ 11: Nhiệm vụ gia tăng sức mạnh

Ra xã hội làm ăn bươn trải, liều thì ăn nhiều, không liều ăn ít, riêng cờ bạc không phải là thứ để chúng ta liều.  
Anh tặng chú 1 câu "Cờ bạc người không chơi là người thắng, Người chơi không bao giờ thắng".  
Đạt các mốc sức mạnh sau

Các bước:

1. Đạt 500k sức mạnh
2. Đạt 550k sức mạnh
3. Đạt 600k sức mạnh
4. Đi về nhà ông %2

### Nhiệm vụ 12: Nhiệm vụ xin phép

Quay về nhà xin ông %2 cho phép tham gia bang hội

Các bước:

1. Đi về nhà %2
2. Nói chuyện - xin phép gia nhập bang hội
3. Báo cáo lại cho %10

### Nhiệm vụ 13: Nhiệm vụ gia nhập bang hội

Gia nhập 1 bang hội cùng những người đồng đội thiện chí\nCùng làm nhiệm với nhau không quản khó khăn

Các bước:

1. Tạo hoặc gia nhập bang hội có 2 thành viên
2. Báo cáo cho %10

### Nhiệm vụ 14: Nhiệm vụ bang hội đầu tiên

Tiến trình sẽ nhanh gấp đôi nếu cùng phối hợp với 1 người đồng đội lên đường làm nhiệm vụ  
Gợi ý:  
Heo rừng xuất hiện tại rừng Bamboo  
Heo da xanh xuất   
hiện tại núi hoa vàng  
Heo xayda xuất hiện tại rừng cọ  
Hãy tới trạm tàu vũ trụ để có thể di chuyển qua các map

Các bước:

1. Tiêu diệt 30 con heo rừng (x30)
2. Tiêu diệt 30 con heo da xanh (x30)
3. Tiêu diệt 30 con heo xayda (x30)
4. Quay về %11 báo cáo nhiệm vụ

### Nhiệm vụ 15: Nhiệm vụ bang hội thứ 2

Tiến trình sẽ nhanh gấp đôi nếu cùng phối hợp với 1 người đồng đội lên đường làm nhiệm vụ

Các bước:

1. Tiêu diệt 30 bulon (x30)
2. Tiêu diệt 30 ukulele (x30)
3. Tiêu diệt 30 quỷ mập (x30)
4. Quay về %11 báo cáo nhiệm vụ

### Nhiệm vụ 16: Tiêu diệt quái vật

Tới các hành tinh tiêu diệt quái vật, giải cứu thường dân

Các bước:

1. Tiêu diệt Tambourine
2. Tiêu diệt Drum
3. Tiêu diệt Akkuman
4. Quay về %11 báo cáo nhiệm vụ

### Nhiệm vụ 17: Nhiệm vụ giúp đỡ Cui

Tìm đường tới thành phố Vegeta, gặp và nói chuyện với Cui

Các bước:

1. Tới Thành Phố Vegeta
2. Nói chuyện với Cui

### Nhiệm vụ 18: Nhiệm vụ bất khả thi

Đạt 50 triệu sức mạnh  
Tiêu diệt bọn tay sai của Fide tại Xayda  
- Thưởng 50.000.000 sức mạnh  
- Thưởng 50.000.000 tiềm năng

Các bước:

1. Tiêu diệt 500 Nappa (x500)
2. Tiêu diệt 400 Soldier (x400)
3. Tiêu diệt 300 Appule (x300)
4. Tiêu diệt 200 Raspberry (x200)
5. Tiêu diệt 100 Thằn lằn xanh (x100)
6. Báo cáo với %10

### Nhiệm vụ 19: Nhiệm vụ tìm diệt đệ tử

Tiêu diệt bọn đệ tử Kuku, Mập Đầu Đinh,  
Rambo của Fide đại ca tại Xayda  
Cui có thể biết vị trí của chúng, nếu tìm  
không thấy hãy đến gặp Cui tại thành  
phố Vegeta  
- Thưởng 20.000.000 sức mạnh  
- Thưởng 20.000.000 tiềm năng

Các bước:

1. Tiêu diệt Kuku
2. Tiêu diệt Mập đầu đinh
3. Tiêu diệt Rambo
4. Trả nhiệm vụ cho %10

### Nhiệm vụ 20: Nhiệm vụ Tiểu đội sát thủ

Tiêu diệt Tiểu Đội Sát Thủ do Fide đại  
ca gọi đến tại Xayda  
- Thưởng 20.000.000 sức mạnh  
- Thưởng 20.000.000 tiềm năng

Các bước:

1. Đạt 600 tr sức mạnh
2. Tiêu diệt Số 4
3. Tiêu diệt Số 3
4. Tiêu diệt Số 2
5. Tiêu diệt Số 1
6. Tiêu diệt Tiểu Đội Trưởng
7. Báo cáo với %10

### Nhiệm vụ 21: Nhiệm vụ chạm trán Fide đại ca

Luyện tập đạt 2 tỷ sức mạnh  
Lên đường tìm diệt Fide đại ca

Các bước:

1. Đạt 2 tỷ sức mạnh
2. Tiêu diệt Fide cấp 1
3. Tiêu diệt Fide cấp 2
4. Tiêu diệt Fide cấp 3
5. Báo cáo với %10

### Nhiệm vụ 22: Chú bé đến từ tương lai

Đến trái đất, rừng bamboo, rừng dương  
xỉ, nam Kamê tìm người lạ  
Đến đảo rùa đưa thuốc cho Quy Lão  
Theo Ca Lích đến tương lai  
Giúp họ diệt bọn bọ hung con  
- Thưởng 1.000.000 sức mạnh  
- Thưởng 1.000.000 tiềm năng

Các bước:

1. Báo cáo với %2
2. Đi tìm vị khách lạ
3. Đưa thuốc trợ tim cho Quy Lão
4. Đến tương lai gặp Bunma
5. Diệt 1000 xên con cấp 1 (x1000)
6. Báo với Bunma tương lai

### Nhiệm vụ 23: Chạm chán Robot sát thủ lần 1

Hãy đến thành phố phía nam  
đảo balê hoặc cao nguyên  
Cùng 2 đồng bang diệt 900 Xên con cấp 3  
Báo với Bunma tương lai  
- Thưởng 1.000.000 sức mạnh  
- Thưởng 1.000.000 tiềm năng

Các bước:

1. Đến điểm hẹn tìm Rôbốt Sát Thủ
2. Tiêu diệt Số 2 (Android 19)
3. Tiêu diệt Số 1 (Android 20)
4. Diệt 900 xên con cấp 3 (x900)
5. Báo với Bunma tương lai

### Nhiệm vụ 24: Chạm trán Robot sát thủ lần 2

Trở về quá khứ, đến sân sau siêu thị  
Tiêu diệt bọn Rôbốt sát thủ  
Báo với Bunma tương lai  
- Thưởng 1.000.000 sức mạnh  
- Thưởng 1.000.000 tiềm năng

Các bước:

1. Đến sân sau siêu thị
2. Tiêu diệt Android 15
3. Tiêu diệt Android 14
4. Tiêu diệt Android 13
5. Báo với Bunma tương lai

### Nhiệm vụ 25: Chạm trán Robot sát thủ lần 3

Đến thành phố, ngọn núi, thung lũng phía Bắc  
Tiêu diệt bọn Rôbốt sát thủ  
Cùng 2 đồng bang diệt 800 Xên con cấp 5  
Báo với Bunma tương lai  
- Thưởng 1.000.000 sức mạnh  
- Thưởng 1.000.000 tiềm năng

Các bước:

1. Đi tìm Píc Póc
2. Tiêu diệt Póc
3. Tiêu diệt Píc
4. Tiêu Diệt Kinh Kong
5. Diệt 800 xên con cấp 5 (x800)
6. Báo với Bunma tương lai

### Nhiệm vụ 26: Chạm trán Xên bọ hung

Đến thị trấn Ginder  
Tiêu diệt Xên Bọ Hung cấp 1  
Tiêu diệt Xên Bọ Hung cấp 2  
Tiêu diệt Xên Bọ Hung hoàn thiện  
Cùng 2 đồng bang diệt 700 Xên con cấp 8  
Báo với Bunma tương lai  
- Thưởng 1.000.000 sức mạnh  
- Thưởng 1.000.000 tiềm năng

Các bước:

1. Đến thị trấn Ginder
2. Tiêu diệt Xên Bọ Hung cấp 1
3. Tiêu diệt Xên Bọ Hung cấp 2
4. Tiêu diệt Xên Bọ Hung hoàn thiện
5. Diệt 700 xên con cấp 8 (x700)
6. Báo với Bunma tương lai

### Nhiệm vụ 27: Cuộc dạo chơi của xên

Cẩn thận !!!  
Những vị khách không mời mà tới  
thường tỏ ra nguy hiểm

Các bước:

1. Nâng sức đánh gốc lên 10K
2. Thu thập Capsule kì bí (x50)
3. Đến võ đài xên bọ hung
4. Tiêu diệt 7 đứa con của xên (x7)
5. Tiêu diệt Siêu Bọ Hung
6. Báo với Bunma tương lai

### Nhiệm vụ 28: Cuộc đối đầu không cân sức

Vào lúc 12h trưa các ngày, bạn đến gặp NPC Ô sin tại map Đại hội võ thuật.

Các bước:

1. Đi theo Ôsin
2. Hạ vua địa ngục Drabura (x10)
3. Hạ Pui Pui (x10)
4. Hạ Pui Pui lần 2 (x10)
5. Hạ Yacôn (x10)
6. Hạ Drabura lần 2 (x10)
7. Hạ Mabư (x10)
8. Báo cáo với Ôsin

### Nhiệm vụ 29: ..

...

Các bước:

1. bạn đã xong nhiệm vụ rồi

## 2. Nhiệm vụ phụ hằng ngày (side_task_template)

| ID | Tên | Lv1 | Lv2 | Lv3 | Lv4 | Lv5 |
|---|---|---|---|---|---|---|
| 0 | Tiêu diệt %1 khủng long | 1-20 | 20-100 | 100-500 | 500-2000 | 2000-5000 |
| 1 | Tiêu diệt %1 lợn lòi | 1-20 | 20-100 | 100-500 | 500-2000 | 2000-5000 |
| 2 | Tiêu diệt %1 quỷ đất | 1-20 | 20-100 | 100-500 | 500-2000 | 2000-5000 |
| 3 | Tiêu diệt %1 khủng long mẹ | 1-20 | 20-100 | 100-500 | 500-2000 | 2000-5000 |
| 4 | Tiêu diệt %1 lợn lòi mẹ | 1-20 | 20-100 | 100-500 | 500-2000 | 2000-5000 |
| 5 | Tiêu diệt %1 quỷ đất mẹ | 1-20 | 20-100 | 100-500 | 500-2000 | 2000-5000 |
| 6 | Tiêu diệt %1 thằn lằn bay | 1-20 | 20-100 | 100-500 | 500-2000 | 2000-5000 |
| 7 | Tiêu diệt %1 phi long | 1-20 | 20-100 | 100-500 | 500-2000 | 2000-5000 |
| 8 | Tiêu diệt %1 quỷ bay | 1-20 | 20-100 | 100-500 | 500-2000 | 2000-5000 |
| 9 | Tiêu diệt %1 thằn lằn mẹ | 1-20 | 20-100 | 100-500 | 500-2000 | 2000-5000 |
| 10 | Tiêu diệt %1 phi long mẹ | 1-20 | 20-100 | 100-500 | 500-2000 | 2000-5000 |
| 11 | Tiêu diệt %1 quỷ bay mẹ | 1-20 | 20-100 | 100-500 | 500-2000 | 2000-5000 |
| 12 | Tiêu diệt %1 heo rừng | 1-20 | 20-100 | 100-500 | 500-2000 | 2000-5000 |
| 13 | Tiêu diệt %1 heo da xanh | 1-20 | 20-100 | 100-500 | 500-2000 | 2000-5000 |
| 14 | Tiêu diệt %1 heo xayda | 1-20 | 20-100 | 100-500 | 500-2000 | 2000-5000 |
| 15 | Tiêu diệt %1 ốc mượn hồn | 1-20 | 20-100 | 100-500 | 500-2000 | 2000-5000 |
| 16 | Tiêu diệt %1 ốc sên | 1-20 | 20-100 | 100-500 | 500-2000 | 2000-5000 |
| 17 | Tiêu diệt %1 heo xayda mẹ | 1-20 | 20-100 | 100-500 | 500-2000 | 2000-5000 |
| 18 | Tiêu diệt %1 không tặc | 1-20 | 20-100 | 100-500 | 500-2000 | 2000-5000 |
| 19 | Tiêu diệt %1 quỷ đầu to | 1-20 | 20-100 | 100-500 | 500-2000 | 2000-5000 |
| 20 | Tiêu diệt %1 quỷ địa ngục | 1-20 | 20-100 | 100-500 | 500-2000 | 2000-5000 |
| 21 | Tiêu diệt %1 heo rừng mẹ | 1-20 | 20-100 | 100-500 | 500-2000 | 2000-5000 |
| 22 | Tiêu diệt %1 heo xanh mẹ | 1-20 | 20-100 | 100-500 | 500-2000 | 2000-5000 |
| 23 | Tiêu diệt %1 alien | 1-20 | 20-100 | 100-500 | 500-2000 | 2000-5000 |
| 24 | Tiêu diệt %1 tambourine | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 25 | Tiêu diệt %1 drum | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 26 | Tiêu diệt %1 akkuman | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 27 | Tiêu diệt %1 nappa | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 28 | Tiêu diệt %1 soldier | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 29 | Tiêu diệt %1 appule | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 30 | Tiêu diệt %1 raspberry | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 31 | Tiêu diệt %1 thằn lằn xanh | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 32 | Tiêu diệt %1 quỷ đầu nhọn | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 33 | Tiêu diệt %1 quỷ đầu vàng | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 34 | Tiêu diệt %1 quỷ da tím | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 35 | Tiêu diệt %1 quỷ già | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 36 | Tiêu diệt %1 cá sấu | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 37 | Tiêu diệt %1 dơi da xanh | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 38 | Tiêu diệt %1 quỷ chim | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 39 | Tiêu diệt %1 lính đầu trọc | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 40 | Tiêu diệt %1 lính tai dài | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 41 | Tiêu diệt %1 lính vũ trụ | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 42 | Tiêu diệt %1 khỉ lông đen | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 43 | Tiêu diệt %1 khỉ giáp sắt | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 44 | Tiêu diệt %1 khỉ lông đỏ | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 45 | Tiêu diệt %1 khỉ lông vàng | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 46 | Tiêu diệt %1 xên con cấp 1 | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 47 | Tiêu diệt %1 xên con cấp 2 | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 48 | Tiêu diệt %1 xên con cấp 3 | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 49 | Tiêu diệt %1 xên con cấp 4 | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 50 | Tiêu diệt %1 xên con cấp 5 | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 51 | Tiêu diệt %1 xên con cấp 6 | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 52 | Tiêu diệt %1 xên con cấp 7 | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 53 | Tiêu diệt %1 xên con cấp 8 | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 54 | Tiêu diệt %1 tai tím | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 55 | Tiêu diệt %1 abo | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 56 | Tiêu diệt %1 kado | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 57 | Tiêu diệt %1 da xanh | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 58 | Nhặt %1 vàng | 1000-3000 | 3000-20000 | 20000-100000 | 100000-10000000 | 10000000-100000000 |

## 3. Nhiệm vụ bang hội (clan_task_template)

| ID | Tên | Lv1 | Lv2 | Lv3 | Lv4 | Lv5 |
|---|---|---|---|---|---|---|
| 0 | Hạ %1 khủng long | 1-20 | 20-100 | 100-500 | 500-2000 | 2000-5000 |
| 1 | Hạ %1 lợn lòi | 1-20 | 20-100 | 100-500 | 500-2000 | 2000-5000 |
| 2 | Hạ %1 quỷ đất | 1-20 | 20-100 | 100-500 | 500-2000 | 2000-5000 |
| 3 | Hạ %1 khủng long mẹ | 1-20 | 20-100 | 100-500 | 500-2000 | 2000-5000 |
| 4 | Hạ %1 lợn lòi mẹ | 1-20 | 20-100 | 100-500 | 500-2000 | 2000-5000 |
| 5 | Hạ %1 quỷ đất mẹ | 1-20 | 20-100 | 100-500 | 500-2000 | 2000-5000 |
| 6 | Hạ %1 thằn lằn bay | 1-20 | 20-100 | 100-500 | 500-2000 | 2000-5000 |
| 7 | Hạ %1 phi long | 1-20 | 20-100 | 100-500 | 500-2000 | 2000-5000 |
| 8 | Hạ %1 quỷ bay | 1-20 | 20-100 | 100-500 | 500-2000 | 2000-5000 |
| 9 | Hạ %1 thằn lằn mẹ | 1-20 | 20-100 | 100-500 | 500-2000 | 2000-5000 |
| 10 | Hạ %1 phi long mẹ | 1-20 | 20-100 | 100-500 | 500-2000 | 2000-5000 |
| 11 | Hạ %1 quỷ bay mẹ | 1-20 | 20-100 | 100-500 | 500-2000 | 2000-5000 |
| 12 | Hạ %1 heo rừng | 1-20 | 20-100 | 100-500 | 500-2000 | 2000-5000 |
| 13 | Hạ %1 heo da xanh | 1-20 | 20-100 | 100-500 | 500-2000 | 2000-5000 |
| 14 | Hạ %1 heo xayda | 1-20 | 20-100 | 100-500 | 500-2000 | 2000-5000 |
| 15 | Hạ %1 ốc mượn hồn | 1-20 | 20-100 | 100-500 | 500-2000 | 2000-5000 |
| 16 | Hạ %1 ốc sên | 1-20 | 20-100 | 100-500 | 500-2000 | 2000-5000 |
| 17 | Hạ %1 heo xayda mẹ | 1-20 | 20-100 | 100-500 | 500-2000 | 2000-5000 |
| 18 | Hạ %1 không tặc | 1-20 | 20-100 | 100-500 | 500-2000 | 2000-5000 |
| 19 | Hạ %1 quỷ đầu to | 1-20 | 20-100 | 100-500 | 500-2000 | 2000-5000 |
| 20 | Hạ %1 quỷ địa ngục | 1-20 | 20-100 | 100-500 | 500-2000 | 2000-5000 |
| 21 | Hạ %1 heo rừng mẹ | 1-20 | 20-100 | 100-500 | 500-2000 | 2000-5000 |
| 22 | Hạ %1 heo xanh mẹ | 1-20 | 20-100 | 100-500 | 500-2000 | 2000-5000 |
| 23 | Hạ %1 alien | 1-20 | 20-100 | 100-500 | 500-2000 | 2000-5000 |
| 24 | Hạ %1 tambourine | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 25 | Hạ %1 drum | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 26 | Hạ %1 akkuman | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 27 | Hạ %1 nappa | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 28 | Hạ %1 soldier | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 29 | Hạ %1 appule | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 30 | Hạ %1 raspberry | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 31 | Hạ %1 thằn lằn xanh | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 32 | Hạ %1 quỷ đầu nhọn | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 33 | Hạ %1 quỷ đầu vàng | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 34 | Hạ %1 quỷ da tím | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 35 | Hạ %1 quỷ già | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 36 | Hạ %1 cá sấu | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 37 | Hạ %1 dơi da xanh | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 38 | Hạ %1 quỷ chim | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 39 | Hạ %1 lính đầu trọc | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 40 | Hạ %1 lính tai dài | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 41 | Hạ %1 lính vũ trụ | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 42 | Hạ %1 khỉ lông đen | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 43 | Hạ %1 khỉ giáp sắt | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 44 | Hạ %1 khỉ lông đỏ | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 45 | Hạ %1 khỉ lông vàng | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 46 | Hạ %1 xên con cấp 1 | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 47 | Hạ %1 xên con cấp 2 | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 48 | Hạ %1 xên con cấp 3 | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 49 | Hạ %1 xên con cấp 4 | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 50 | Hạ %1 xên con cấp 5 | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 51 | Hạ %1 xên con cấp 6 | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 52 | Hạ %1 xên con cấp 7 | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 53 | Hạ %1 xên con cấp 8 | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 54 | Hạ %1 tai tím | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 55 | Hạ %1 abo | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 56 | Hạ %1 kado | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 57 | Hạ %1 da xanh | 1-5 | 5-20 | 20-100 | 100-500 | 500-1000 |
| 58 | Nhặt %1 vàng | 1000-3000 | 3000-20000 | 20000-100000 | 100000-10000000 | 10000000-100000000 |

## 4. Nhiệm vụ danh hiệu (task_badges_template)

| ID | Tên | Số lượng | ID danh hiệu thưởng |
|---|---|---|---|
| 1 | Nạp Tích luỹ 1 Triệu Trong Ngày | 1000000 | 218 |
| 2 | Ước Rồng Thần 1 Sao X100 Lần | 100 | 219 |
| 3 | Hạ Gục Cumber, Black Goku, Cooler, Xên ( 300 Lần ) | 300 | 220 |
| 4 | Đập 5 Trang Bị +7 Trong Ngày | 5 | 221 |
| 5 | Top 1 Đại Hội Võ Đài Siêu Hạng | 1 | 222 |
| 6 | Hoàn Thành 10 Nhiệm Vụ Siêu Khó Tại Bò Mộng | 10 | 223 |
| 7 | Đánh Bại, Hoặc Cho Xương Sói 20 Lần | 20 | 1286 |
| 8 | Hoàn Thành Nhiệm Vụ 5 Lần Cho Xinbato Nước | 5 | 1287 |
| 9 | Nhặt Đồ Trong Ngày 500 Lần | 500 | 224 |
| 10 | Tiêu diệt 30 Boss Ăn Trộm | 30 | 225 |
| 11 | Tiêu Diệt 30 Boss Ở Dơ | 30 | 1300 |
| 12 | Mở Rương Gỗ Cấp 12 | 10 | 240 |
| 13 | Mở Rương Gỗ Cấp 12 | 20 | 242 |
| 14 | Mở Rương Gỗ Cấp 12 | 30 | 243 |
| 15 | Đạt 500 Điểm Sự Kiện | 500 | 247 |
| 16 | Nạp tích lũy 2 triệu trong ngày | 2000000 | 253 |
| 17 | Sở hữu 7 rồng nhí vĩnh viễn | 7 | 256 |
| 18 | Fan cứng KOL | 1 | 226 |
