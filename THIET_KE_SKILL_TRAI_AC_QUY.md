# Thiết kế skill và Trái Ác Quỷ (One Piece, đến Marineford)

Nguồn duy nhất cho phần skill. Chưa sửa code nào. Hình ảnh dùng lại asset cũ, chưa build lại client.

**Nhãn:** [CHỐT] bạn đã đồng ý. [ĐỀ XUẤT] mình đề xuất, chưa được xác nhận rõ. [ĐÃ ĐỌC] lấy từ code hoặc DB gốc.

Trạng thái: bạn đã nói "để như này đã", nên bản dưới đây là bản hiện hành. Bốn điểm trong mục 8 được ghi theo giả định mình đã nêu, chưa có xác nhận riêng.

---

## 1. Bộ 5 skill

| Skill | Là gì | Mở lúc |
|---|---|---|
| 1 | Đấm (theo phe) | Từ đầu [CHỐT] |
| 2 | Chưởng (theo phe) | Từ đầu [CHỐT] |
| 3 | Chọn hệ Logia / Paramecia / Zoan, được skill tương ứng | NV9 (bái sư), mốc gốc 60.000 sức mạnh [ĐỀ XUẤT] |
| 4 | Trái Ác Quỷ (theo hệ và bậc) | Nhận trái Thường ở NV16 [ĐỀ XUẤT] |
| 5 | Skill mặc định của phe | NV19, mốc gốc khoảng 150 triệu [ĐỀ XUẤT] |

Cả 5 skill tối đa cấp 10 [CHỐT]. Chưa có Haki và trái thứ hai: để sau Marineford.

**Phe và hệ độc lập nhau** [CHỐT]: chọn phe lúc tạo nhân vật, chọn hệ ở NV9, tự do ghép 3 phe × 3 hệ = 9 tổ hợp.

## 2. Ba phe

Ánh xạ [CHỐT]: Hải Tặc (HT) = Trái Đất, Hải Quân (HQ) = Xayda, Cách Mạng (QCM) = Namếc. Nhân vật chọn: HT Luffy/Zoro/Sanji, HQ Aokiji/Akainu/Kizaru, QCM Dragon/Sabo/Kuma.

| Phe | Skill 1 | Skill 2 | Skill 5 [vai trò CHỐT, tên ĐỀ XUẤT] | Cơ chế gốc dùng lại |
|---|---|---|---|---|
| HT | Hải Tặc Quyền | Phi Điểu Trảm | Hắc Cước Liên Hoàn: choáng cả nhóm | Thái Dương Hạ San (choáng 3–9 giây) |
| HQ | Shigan (Chỉ Thương) | Rankyaku (Phi Cước Trảm) | Tekkai (Thiết Khối): tăng máu tối đa | Biến hình / Huýt sáo |
| QCM | Long Trảo Quyền | Phong Bạo Chưởng | Bão Rồng Hủy Diệt: huỷ diệt, giết boss | Makankosappo (nạp 3 giây) |

**Chỉ số chính mỗi phe** [ĐÃ ĐỌC trong `NPoint` và `SkillService`]:
- Trái Đất: Quả cầu kênh khí = 10% tổng máu quái và người trong tầm + 10 × sức đánh.
- Namếc: Makankosappo = KI tối đa × %.
- Xayda: Tự phát nổ = máu hiện tại; người dùng chết; boss giảm một nửa.

Vậy HT = **SĐ**, QCM = **KI**, HQ = **HP**.

**Vai trò trong trận** [ĐỀ XUẤT, từ số liệu skill gốc]:

| Phe | Đặc điểm gốc | Vai trò |
|---|---|---|
| HT | Kamejoko mạnh nhất nhưng chậm (150→450%, hồi 2–5 giây). Thái Dương choáng cả nhóm | Mở màn: choáng rồi ra đòn lớn. Nếu chưa hạ được thì dễ thua khi trận kéo dài |
| QCM | Đấm 0,4 giây (nhanh nhất), Masenko hồi 0,7 giây, KI gốc cao nhất | Kéo dài trận: nhiều đòn nhỏ, hợp hút máu và chí mạng |
| HQ | Sức đánh gốc cao nhất (con số 15 từ bản cũ, chưa đọc lại), Antomic mạnh, Tekkai thêm máu | Solo bền: chịu đòn và đánh mạnh khi đã vào trận |

Ý chính [CHỐT]: HT mở màn bằng choáng và sát thương nhanh. Nếu không giết được thì QCM hoặc HQ lật thế trận ở trận kéo dài.

## 3. Skill 3: theo hệ [CHỐT]

| Hệ | Hiệu ứng | Cơ chế gốc làm mẫu |
|---|---|---|
| Logia | Dịch chuyển tới cạnh mục tiêu, gây choáng | Dịch chuyển tức thời |
| Paramecia | Tăng sát thương vài giây, hồi máu mỗi giây cho mọi người xung quanh | Huýt sáo + Tái tạo năng lượng |
| Zoan | Hút máu, tăng tỉ lệ chí mạng | Cơ chế mới (hút máu không có trong game gốc) |

## 4. Cân bằng trái

- **Trái Hiếm = 100 điểm** là mốc chuẩn. Điểm là chỉ số quy đổi chung, kể cả trái buff và trái farm [ĐỀ XUẤT, chưa đo trên server thật].
- **Thường = 92** (yếu hơn Hiếm 5–10%) [CHỐT].
- **Thần thoại = 100 + hiệu ứng cộng thêm** [CHỐT].
- **Trái Sét ≈ 190**, mạnh hơn hẳn [CHỐT mức "hơn hẳn", con số ĐỀ XUẤT].
- **Cộng hưởng +15%** khi chỉ số của trái trùng chỉ số chính của phe [ĐỀ XUẤT].
- **Boss giảm sát thương:** chia 2, và có trần [ĐỀ XUẤT, theo mẫu Tự phát nổ gốc].
- Hồi chiêu: Thường 15–30 giây; Hiếm 90–180 giây; Thần thoại 240–300 giây; Trái Sét 600 giây [ĐỀ XUẤT, tham khảo chiêu lớn gốc hồi 300–540 giây].
- **Quy tắc chỉ số:** mỗi hệ có đủ cả 3 chỉ số SĐ, KI, HP ở 3 bậc. Nhờ vậy mỗi tổ hợp (phe × hệ) có đúng một bậc trái hợp chỉ số chính của phe. Ở bậc Thần thoại, mỗi phe có đúng một trái hợp.
- Với trái không có sát thương trực tiếp (Ope, Phượng Hoàng), "tính theo chỉ số" nghĩa là chỉ số đó quyết định độ lớn hiệu ứng. Định nghĩa cụ thể khi viết số liệu.

## 5. Bảng 9 trái theo hệ + Trái Sét

| Hệ | Thường (92) | Hiếm (100) | Thần thoại (100 + hiệu ứng) |
|---|---|---|---|
| **Logia** | **Hie Hie, Băng** · **HP**: giáp băng hấp thụ sát thương theo % máu tối đa, kẻ đánh bị chậm hoặc đóng băng ngắn | **Magu Magu, Đại Phun Trào** · **KI**: công thức Quả cầu kênh khí, thay phần sức đánh bằng KI, tụ 4 giây | **Yami Yami, Hố Đen** · **SĐ** |
| **Paramecia** | **Zushi Zushi, Trọng Lực** · **SĐ**: ép mục tiêu xuống, chậm + choáng 1 giây | **Ope Ope, Room** · **HP**: vùng 10 giây, đồng đội hồi KI, giảm 25% hồi chiêu, kẻ địch bị chậm | **Gura Gura, Địa Chấn** · **KI** |
| **Zoan** | **Dã Thú Hoá** · x2 **SĐ** 15 giây (bản nhẹ của Rồng, không có chùm phun) | **Tori Tori, Phượng Hoàng** · x2 **KI**: chim đi theo, **farm quái** | **Uo Uo, Rồng Xanh** · x2 **HP** |

Vai trò [CHỐT]: Phượng Hoàng là trái farm; Trọng Lực, Hie Hie, Gura Gura là khống chế; Dã Thú Hoá là "như thần thoại nhưng yếu hơn"; Ope là buff đội.

Bậc Thần thoại ưu tiên chỉ số [CHỐT]: Logia = SĐ, Zoan = HP, Paramecia = KI. ("QCM" trong tin nhắn của bạn mình đọc là Paramecia.)

### Hiệu ứng cộng thêm của trái Thần thoại [CHỐT ý tưởng, số ĐỀ XUẤT]

- **Yami Yami** (tính theo SĐ): tạo hố đen dưới mục tiêu. Mục tiêu nhận x2 sát thương trong 6–10 giây, sau đó hố nổ, phản lại thêm sát thương. Có tỉ lệ kết liễu dưới 3% máu (bỏ qua boss). Điều kiện: mục tiêu đang bị khống chế (choáng, ngủ, trói).
- **Gura Gura** (tính theo KI): chấn động cả khu, choáng 2–3 giây, thêm sát thương theo % máu tối đa của mục tiêu. Boss giảm một nửa, có trần.
- **Rồng Xanh** (x2 HP):
  - Lần bấm 1: biến rồng, máu tối đa x2, chí mạng tăng.
  - Lần bấm 2: phun chùm năng lượng, **sát thương = máu hiện tại của người dùng** (công thức Tự phát nổ gốc, `dame = hp`), **không bị trừ máu và không chết**, rồi hết biến. Boss giảm một nửa (dạng biến hình gốc chia 3).
  - Cảnh báo: gốc phải hy sinh mạng, trái này thì không. Hồi chiêu dài và giảm sát thương boss giữ cân bằng. Cần đo lại.

### Zoan luôn tăng máu và chí mạng [CHỐT ý, số ĐỀ XUẤT]

Mọi trái Zoan, khi đang cầm, **luôn cộng thêm máu tối đa và chí mạng** (không cần bật skill):

| Bậc | Máu tối đa | Chí mạng |
|---|---|---|
| Thường | +8% | +3% |
| Hiếm | +10% | +4% |
| Thần thoại | +12% | +5% |

Phần này đã tính vào điểm sức mạnh của trái. Mỗi trái Zoan còn x2 một chỉ số riêng (bảng trên).

### Phượng Hoàng (farm) [ĐỀ XUẤT]

- Triệu hồi chim lửa đi theo 120 giây, chỉ đánh quái, theo kiểu Đẻ trứng của Namếc.
- Khi chim còn sống: tăng sát thương lên quái thường, tăng sức mạnh/tiềm năng nhận được, tăng vàng rơi. Khoảng +15% ở cấp 1 đến +30% ở cấp 10.
- Không tăng sát thương lên người hay boss.
- Game gốc đã có nội tại tăng vàng và sức mạnh khi đánh quái, nên cần đặt trần tổng cộng.

### Trái Sét [CHỐT]

- Tính theo **chỉ số chính của phe** (HT = SĐ, QCM = KI, HQ = HP), nên luôn được cộng hưởng +15%.
- **Chỉ rơi, không mua. Tỉ lệ rơi thấp.**
- **Chỉ rơi từ boss Enel.** Enel là ngoại lệ so với cốt truyện (Skypiea bị bỏ qua).
- Cơ chế [ĐỀ XUẤT]:
  - Bấm lần 1, "Thần Sấm" 20 giây: đòn thường kèm sét lan sang tối đa 3 mục tiêu, tăng tốc độ di chuyển, miễn choáng.
  - Bấm lần 2, "Thiên Lôi Thần Phạt": sét giáng xuống mọi kẻ địch trong khu, choáng 3 giây, rồi hết trạng thái. Boss giảm một nửa, có trần.
  - Hồi chiêu 600 giây.

## 6. Cách có trái và đổi trái

- Mỗi người chỉ cầm **1 trái** [CHỐT].
- Mọi người nhận một **trái Thường theo hệ đã chọn** ở NV16 [ĐỀ XUẤT].
- Muốn đổi trái: **mua** hoặc **đánh boss mạnh** [CHỐT]. Cái nào mua được, cái nào chỉ rơi, giá và tỉ lệ: chưa quyết (Phần 4).
- Trái Sét: chỉ rơi từ Enel, không mua được.
- Hệ đã chọn ở skill 3 không đổi.

## 7. Phối hợp giữa các skill

**Trái hợp phe nào** (theo chỉ số):

| Phe (chỉ số) | Logia | Paramecia | Zoan |
|---|---|---|---|
| HT (SĐ) | Thần thoại (Yami) | Thường (Trọng Lực) | Thường (Dã Thú) |
| QCM (KI) | Hiếm (Magu) | Thần thoại (Gura) | Hiếm (Phượng Hoàng) |
| HQ (HP) | Thường (Hie Hie) | Hiếm (Ope) | Thần thoại (Rồng) |

**Ghép tốt theo vai trò** [ĐỀ XUẤT]:

| Phe | Ghép tốt | Vì sao |
|---|---|---|
| HT | Logia | Skill 3 và skill 5 đều choáng, Kamejoko chậm nên cần choáng để trúng. Hố Đen cần mục tiêu bị khống chế. Magu tụ 4 giây cũng cần choáng |
| QCM | Zoan hoặc Paramecia | Đấm 0,4 giây ra nhiều đòn nhỏ, mỗi đòn đều hút máu và có chí mạng |
| HQ | Zoan | Tekkai tăng máu tối đa, chùm phun Rồng tính theo máu hiện tại |

Không có tổ hợp bắt buộc: mọi tổ hợp 3 phe × 3 hệ đều chơi được.

## 8. Chưa làm / chưa quyết

Giả định chưa có xác nhận riêng:
- "QCM: KI" là Paramecia.
- Magu Magu tính theo KI (thay phần sức đánh).
- Hie Hie là trái Logia Thường thay Hỏa Quyền.
- Yami Yami tính theo SĐ.

Còn mở:
- Số liệu cụ thể từng cấp 1–10 (sát thương %, KI, hồi chiêu): làm sau, cần đo trên server.
- Giá, tỉ lệ rơi, danh sách boss rơi từng trái: Phần 4.
- Enel xuất hiện ở đâu, khi nào, bằng cách nào: Phần 3.
- Điều kiện mục tiêu bị khống chế của Yami Yami: chờ xác nhận.
- Thời điểm mở skill 3/4/5 (NV9/NV16/NV19): chờ xác nhận.
- Khối lượng code: hút máu, hố đen, kết liễu, chuyển dạng, trái Sét, giáp băng, x2 chỉ số là cơ chế mới viết trong `SkillService`. Hình ảnh dùng asset cũ. Mã skill có nằm gọn 1 byte (dưới 256) hay không thì **chưa kiểm tra**.
