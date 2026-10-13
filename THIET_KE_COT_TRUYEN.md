# Thiết kế cốt truyện One Piece (đến Marineford)

Chưa sửa code nào. Hình ảnh dùng lại asset cũ.

**Nhãn:** [CHỐT] bạn đã đồng ý. [ĐỀ XUẤT] mình chọn, bạn bảo "chọn hợp lý là được", chưa duyệt từng chỗ. [ĐÃ ĐỌC] lấy từ code hoặc DB gốc.

Liên quan: skill và trái ở `THIET_KE_SKILL_TRAI_AC_QUY.md`, kho báu và trang bị ở `THIET_KE_KHO_BAU_TRANG_BI.md`, hệ thống gốc ở `README.md`.

---

## 1. Nguyên tắc

- Giữ **nguyên số liệu gốc**: mốc sức mạnh, số lượng quái, số bước của từng nhiệm vụ. Chỉ đổi tên, bối cảnh [ĐỀ XUẤT, theo nguyên tắc trong `ONEPIECE_THIET_KE.xlsx`].
- Mỗi chặng thay đúng chặng cùng vị trí của game gốc (29 nhiệm vụ, id 0–28, id 29 là "hết").
- **NV 0–15 giữ id** vì client có chỗ so sánh `taskId` cố định [theo phiên trước, chưa kiểm tra lại].
- Cốt truyện dừng ở **Marineford**. Chưa có Haki và trái ác quỷ thứ hai [CHỐT].
- **Bỏ qua** Loguetown, Reverse Mountain, Skypiea, Jaya để giữ đúng cấu trúc [ĐỀ XUẤT]. Enel là ngoại lệ, chỉ làm boss kho báu [CHỐT].

## 2. Ba phe, bộ sư phụ, tên địa danh

Ánh xạ [CHỐT]: Hải Tặc (HT) = Trái Đất, Hải Quân (HQ) = Xayda, Cách Mạng (QCM) = Namếc. Nhân vật chọn: HT Luffy/Zoro/Sanji, HQ Aokiji/Akainu/Kizaru, QCM Dragon/Sabo/Kuma.

**Sư phụ** [ĐỀ XUẤT]: HT **Rayleigh** (Sabaody), QCM **Ivankov** (Kamabakka), HQ **Garp** (Marineford). Mình chọn bộ này vì địa danh khớp đúng bản đồ mà bạn đã lập trong `ONEPIECE_THIET_KE.xlsx` (Sabaody, Kamabakka, Marineford). Trước đây từng duyệt Shanks/Hack/Garp, nay đổi Rayleigh và Ivankov. Shanks xuất hiện ở đoạn kết Marineford (cameo).

**Bảng placeholder `%1`–`%14`** [ĐỀ XUẤT]. Ý nghĩa từng mã mình đối chiếu với README mục 1 (đọc từ `TaskService.transformName`), đã sửa chỗ xlsx hiểu sai (ví dụ `%8` là NPC cửa hàng làng, không phải dân cần cứu).

| Mã | Ý nghĩa thật | Hải Tặc | Cách Mạng | Hải Quân |
|---|---|---|---|---|
| %1 | Làng khởi đầu | Làng Foosha | Căn cứ Baltigo | Căn cứ Hải quân Shells Town |
| %2 | Người nuôi ở nhà | ông Woop Slap | ông Hack | ông Sengoku |
| %3 | Map săn ~200 sức mạnh | Rừng Dawn | Rừng Tuyết Baltigo | Bờ biển Shells |
| %4 | Quái đầu | Hổ Rừng | Sói Băng | Cướp Biển Tép |
| %5 | Vách núi | Vách núi Dawn | Vách núi Baltigo | Vách núi Shells |
| %6 | Map ~500 | chưa chốt | chưa chốt | chưa chốt |
| %7 | NPC trạm tàu | chưa chốt | chưa chốt | chưa chốt |
| %8 | NPC cửa hàng làng | Makino | Koala | Coby |
| %9 | Quái bay | Hải Âu Chiến | Rắn Biển Nhỏ | Dơi Đêm |
| %10 | Sư phụ | Rayleigh | Ivankov | Garp |
| %11 | Nơi ở sư phụ | Quần đảo Sabaody | Đảo Kamabakka | Marineford |
| %12 | Quái ~3000 | Lợn Biển | Cua Giáp | Bạch Tuộc Con |
| %13 | Map ~600 | Rừng Hoang Syrup | Thung lũng Baltigo | Hầm mỏ Shells |
| %14 | Nhóm quái mẹ ~1000 / băng cướp | Băng cướp Buggy | Binh đoàn Thế Giới | Băng Hải Tặc Krieg |

## 3. Các chặng cốt truyện

| NV | Chặng gốc | Chặng One Piece | Nội dung |
|---|---|---|---|
| 0–6 | Làng, tập luyện | **Khởi hành** | Ở nhà, đánh bao cát, săn thịt (học Geppo), vớt hòm gỗ trôi dạt, 3 quái "chúa" của 3 vùng (thay "quái mẹ") |
| 7–8 | Giải cứu, tìm ngọc | **Orange Town và Poneglyph** | Giải cứu dân, tìm phiến Poneglyph đầu tiên bị `%14` cướp (thay ngọc 7 sao) |
| 9–11 | Bái sư, thử sức, luyện | **Sư phụ** | Gặp `%10` ở `%11`, thử sức, luyện tới 600k sức mạnh. **Chọn hệ trái ở NV9** |
| 12–13 | Xin phép, vào bang | **Lập thuyền** | Về xin phép, lập hoặc vào thuyền có 2 người (thuyền chung cả 3 phe, tối đa 10 [CHỐT]) |
| 14–15 | Bang hội đầu tiên, thứ 2 | **Đông Hải** | Nhiệm vụ đi theo thuyền, mỗi nhiệm vụ 3 loại quái 30 con ở 3 map |
| 16–18 | Tambourine/Drum/Akkuman, Cui, tay sai Fide | **Arlong** | Kuroobi, Chew, Hatchan → gặp Nami ở Cocoyasi → lính Arlong (500/400/300/200/100). **Nhận trái Thường ở NV16** |
| 19–21 | Đệ tử Fide, tiểu đội, Fide | **Alabasta** | Mr.7, Mr.5, Miss Valentine → Officer Agents (Mr.3, Miss Goldenweek, Miss Doublefinger, Mr.2, Mr.1) → Crocodile cấp 1/2/hoàn thiện. **Mở skill 5 ở NV19** |
| 22–26 | Tương lai, Android, Xên | **Water 7 và Enies Lobby** | Franky, đưa thuốc cho Kureha, Galley-La, CP9 lần 1/2/3, Rob Lucci (3 dạng). Nico Robin là NPC báo cáo |
| 27 | Cuộc dạo chơi của Xên | **Thriller Bark** | Bóng ma, zombie, Gecko Moria |
| 28 | Đại hội võ thuật 12h trưa | **Marineford** | 12h trưa hằng ngày, 6 trận mỗi trận 10 con, xem mục 4 |
| 29 | Hết | Hết | Chỗ trống cho chặng sau Marineford |

Mốc sức mạnh yêu cầu giữ nguyên: NV18 đòi 50 triệu, NV20 đòi 600 triệu, NV21 đòi 2 tỷ [ĐÃ ĐỌC `task_sub_template`].

**Chỗ chưa chốt trong bảng:**
- CP9 ở NV23–25 cần 8 boss: Kaku, Kalifa (NV23); Jabra, Blueno, Kumadori (NV24); Fukuro, Spandam và **một boss thứ ba chưa chốt** (NV25). Xlsx của bạn chỉ ghi chung "đặc vụ CP9".
- NV27: bước "Nâng sức đánh gốc lên 10K" trong DB tự mâu thuẫn với thông báo của chính nó là 35K [ĐÃ ĐỌC]. Cần chọn một con số.
- Arlong cần xuất hiện ở NV18, nhưng bước cuối NV18 là "100 con" chứ không phải một boss. Phải thêm bước boss hoặc cho Arlong xuất hiện khi hoàn thành. Cần sửa code nhiệm vụ.
- Thưởng sức mạnh/tiềm năng/vàng của từng nhiệm vụ theo code gốc, README mục 5.2. NV25–29 gốc không có thưởng.

## 4. Marineford (NV28)

Gốc: 6 trận, mỗi trận 10 con boss, theo thứ tự Drabura, Pui Pui, Pui Pui lần 2, Yacôn, Drabura lần 2, Mabư [ĐÃ ĐỌC]. NPC báo cáo: Ôsin, gặp lúc 12h trưa.

Mới [ĐỀ XUẤT]: NPC là lính Den Den Mushi. Sáu trận theo thứ tự:

| Trận | Boss |
|---|---|
| 1 | Momonga |
| 2 | Doberman |
| 3 | Magellan |
| 4 | Smoker |
| 5 | Sengoku |
| 6 | Edward Newgate (Râu Trắng), trận cuối |

Mình chọn boss **không trùng nhân vật người chơi chọn** (Aokiji, Akainu, Kizaru, Garp là sư phụ). Râu Trắng là chủ nhân Gura Gura, hợp cuối chiến tranh. Đoạn kết: Shanks xuất hiện (cameo, không đánh).

## 5. Poneglyph, thuyền, kho báu trong cốt truyện

- NV8: nhận phiến Poneglyph đầu tiên.
- NV13: lập hoặc vào thuyền.
- NV22–26: Nico Robin là NPC đổi vé. Đổi 4, 9 hoặc 17 phiến lấy vé tương ứng [ĐỀ XUẤT].
- Sau Marineford: vòng chơi lặp lại là gom phiến, mở kho báu, đánh Enel nhiều cấp, nâng cấp đồ. Chi tiết trong `THIET_KE_KHO_BAU_TRANG_BI.md`.

## 6. Mốc kỹ năng theo cốt truyện

| NV | Sự kiện |
|---|---|
| 2 | Học Geppo (thay kỹ năng bay) |
| 9 | Chọn hệ trái, nhận skill 3 |
| 16 | Nhận trái Thường theo hệ, skill 4 |
| 19 | Mở skill 5 theo phe |

## 7. Chưa kiểm tra / chưa làm

- Client có gắn cứng `taskId` ở đâu (XmapData, GameScr...): cần đọc lại trước khi sửa nhiệm vụ.
- Mô tả chi tiết từng bước nhiệm vụ bằng văn bản đầy đủ (tên bước, thông báo) cho 125 bước: chưa viết, làm khi bắt đầu đưa vào dữ liệu.
- Boss thứ ba của NV25, con số 10K/35K của NV27, tên cho `%6` và `%7`.
