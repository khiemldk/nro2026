#!/usr/bin/env bash
# Kiểm tra TRƯỚC TỪNG BƯỚC trong HUONG_DAN_CHAY_DU_AN.md.
# Script CHỈ ĐỌC: không cài đặt, không sửa file, không xoá gì.
#
# Dùng:
#   bash kiem_tra_truoc_khi_cai.sh 3     # kiểm tra trước Bước 3
#   bash kiem_tra_truoc_khi_cai.sh       # kiểm tra lần lượt Bước 1 đến 9

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$ROOT/SRC"
CFG="$SRC/Config.properties"
DUMP="$ROOT/database team2026.sql"
CT="nro-mariadb"            # tên container Docker dùng ở Bước 2

OK=0; WARN=0; FAIL=0
ok()   { printf "  [ OK ]  %s\n" "$1"; OK=$((OK+1)); }
warn() { printf "  [CHÚ Ý] %s\n" "$1"; WARN=$((WARN+1)); }
fail() { printf "  [LỖI]   %s\n" "$1"; FAIL=$((FAIL+1)); }
info() { printf "          %s\n" "$1"; }
hdr()  { printf "\n== Kiểm tra trước Bước %s\n" "$1"; }

cfg() { grep -E "^[[:space:]]*$1[[:space:]]*=" "$CFG" 2>/dev/null | tail -1 | cut -d= -f2- | tr -d '\r' | sed 's/[[:space:]]*#.*$//; s/^[[:space:]]*//; s/[[:space:]]*$//'; }
port_used()  { lsof -nP -iTCP:"$1" -sTCP:LISTEN >/dev/null 2>&1; }
port_owner() { lsof -nP -iTCP:"$1" -sTCP:LISTEN 2>/dev/null | awk 'NR==2{print $1" (pid "$2")"}'; }
docker_up()  { command -v docker >/dev/null 2>&1 && docker info >/dev/null 2>&1; }
ct_exists()  { docker ps -a --format '{{.Names}}' 2>/dev/null | grep -qx "$CT"; }
ct_running() { [ "$(docker inspect -f '{{.State.Running}}' "$CT" 2>/dev/null)" = "true" ]; }

# Chạy câu SQL trong container bằng tài khoản trong Config (mật khẩu truyền qua biến môi trường, không lộ ở dòng lệnh)
dbq() { docker exec -e MYSQL_PWD="$(cfg database.pass)" "$CT" mariadb -u"$(cfg database.user)" -N -e "$1" 2>/dev/null; }

check_java() {
  if command -v java >/dev/null 2>&1; then
    local v m; v="$(java -version 2>&1 | head -1)"
    m="$(java -version 2>&1 | head -1 | sed -E 's/.*version "([0-9]+)(\.[0-9]+)?.*/\1/')"
    if [ "${m:-0}" -ge 17 ] 2>/dev/null; then ok "Java: $v"; return 0; else fail "Java quá cũ ($v), cần 17 trở lên"; return 1; fi
  else
    fail "chưa cài Java"; return 1
  fi
}

check_config_exists() {
  if [ -f "$CFG" ]; then ok "có SRC/Config.properties"; return 0; else fail "thiếu SRC/Config.properties"; return 1; fi
}

check_db_reachable() {   # kiểm tra kết nối tới DB theo Config
  local h p; h="$(cfg database.host)"; p="$(cfg database.port)"
  if nc -z -w 2 "${h:-localhost}" "${p:-3306}" >/dev/null 2>&1; then ok "DB trả lời tại ${h:-localhost}:${p:-3306}"; return 0
  else fail "không kết nối được DB tại ${h:-localhost}:${p:-3306} (DB chưa chạy hoặc sai database.port)"; return 1; fi
}

step1() {  # Cài Java
  hdr 1
  if check_java; then info "Đã có Java phù hợp: có thể BỎ QUA Bước 1."; fi
  command -v brew >/dev/null 2>&1 && ok "có Homebrew" || warn "chưa có Homebrew (cài Java theo cách khác)"
}

step2() {  # Cài và khởi động database
  hdr 2
  if command -v docker >/dev/null 2>&1; then
    if docker_up; then ok "Docker đang chạy"; else fail "Docker đã cài nhưng chưa chạy. Mở Docker Desktop rồi chạy lại"; fi
  else
    warn "chưa có lệnh docker (dùng Cách B/C nếu không muốn Docker)"
  fi
  if docker_up; then
    if ct_exists; then
      if ct_running; then ok "container $CT đã có và đang chạy: có thể BỎ QUA Bước 2"; else warn "container $CT đã có nhưng đang dừng. Chạy: docker start $CT (đừng docker run lại, sẽ báo trùng tên)"; fi
    else
      ok "chưa có container $CT: có thể tạo mới"
    fi
  fi
  if port_used 3307; then
    if docker_up && ct_running; then info "cổng 3307 đang được $CT dùng"; else fail "cổng 3307 đang bị chiếm bởi $(port_owner 3307). Đổi cổng -p trong lệnh docker run"; fi
  else
    ok "cổng 3307 còn trống"
  fi
  if command -v brew >/dev/null 2>&1 && brew list --versions mysql >/dev/null 2>&1; then
    warn "Homebrew đã có MySQL ($(brew list --versions mysql)): KHÔNG chạy 'brew install mariadb' (Cách B), dùng Docker"
    local dd="/opt/homebrew/var/mysql" others
    others="$(ls -d "$dd"/*/ 2>/dev/null | xargs -n1 basename 2>/dev/null | grep -vE '^(mysql|performance_schema|sys|#innodb_redo|#innodb_temp)$' | tr '\n' ' ')"
    [ -n "$others" ] && warn "thư mục dữ liệu MySQL có DB riêng của bạn: $others"
  fi
  local gb; gb="$(df -g "$ROOT" 2>/dev/null | awk 'NR==2{print $4}')"
  [ -n "$gb" ] && { [ "$gb" -ge 3 ] && ok "ổ đĩa trống ${gb} GB" || warn "ổ đĩa chỉ còn ${gb} GB"; }
}

step3() {  # Tạo database và import dữ liệu
  hdr 3
  if [ -f "$DUMP" ]; then
    local n; n="$(grep -c '^CREATE TABLE' "$DUMP")"
    ok "có database team2026.sql ($(du -h "$DUMP" | cut -f1), $n bảng)"
  else
    fail "thiếu file database team2026.sql"
  fi
  if ! docker_up; then fail "Docker chưa chạy, chưa thể import (làm Bước 2 trước)"; return; fi
  if ! ct_exists; then fail "chưa có container $CT (làm Bước 2 trước)"; return; fi
  if ! ct_running; then fail "container $CT đang dừng. Chạy: docker start $CT"; return; fi
  if [ -z "$(cfg database.pass)" ] && [ ! -f "$CFG" ]; then warn "chưa có Config để lấy mật khẩu, dùng mật khẩu mặc định nro123"; fi
  local pw; pw="$(cfg database.pass)"; [ -z "$pw" ] && pw="nro123"
  if docker exec -e MYSQL_PWD="$pw" "$CT" mariadb -uroot -e "SELECT 1" >/dev/null 2>&1; then ok "đăng nhập root vào DB thành công"
  else fail "không đăng nhập được vào DB với mật khẩu '$( [ -n "$(cfg database.pass)" ] && echo 'trong Config' || echo 'nro123')'. DB có thể đang khởi động, đợi 15 giây rồi chạy lại"; return; fi
  local db t; db="$(cfg database.name)"; db="${db:-team2026}"
  t="$(docker exec -e MYSQL_PWD="$pw" "$CT" mariadb -uroot -N -e "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='$db'" 2>/dev/null)"
  if [ -z "$t" ]; then fail "không đọc được số bảng của DB $db"
  elif [ "$t" = "0" ]; then ok "DB $db đã tồn tại và còn trống: có thể import"
  elif [ "$t" = "41" ]; then ok "DB $db đã có 41 bảng: ĐÃ import rồi, KHÔNG import lại (sẽ báo trùng bảng)"
  else warn "DB $db đang có $t bảng (dự kiến 0 hoặc 41). Import vào DB không trống có thể lỗi trùng bảng"; fi
}

step4() {  # Chỉnh Config.properties
  hdr 4
  check_config_exists || return
  info "server.ip=$(cfg server.ip)   server.port=$(cfg server.port)"
  info "database: $(cfg database.user)@$(cfg database.host):$(cfg database.port)/$(cfg database.name)  mật khẩu: $([ -n "$(cfg database.pass)" ] && echo 'đã đặt' || echo 'TRỐNG')"
  [ -f "$CFG.bak" ] && ok "đã có bản sao lưu Config.properties.bak" || warn "chưa sao lưu. Nên chạy: cp SRC/Config.properties SRC/Config.properties.bak"
  if grep -qE '^[[:space:]]*server\.sv[0-9]+[[:space:]]*=' "$CFG"; then
    warn "vẫn còn server.svN trỏ ra ngoài: $(grep -E '^[[:space:]]*server\.sv[0-9]+' "$CFG" | tr -d '\r' | head -1). Xoá hoặc comment nếu không chủ ý dùng"
  else ok "không có server.svN trỏ ra ngoài"; fi
  local lan; lan="$(ipconfig getifaddr en0 2>/dev/null)"
  [ -n "$lan" ] && info "IP LAN của Mac (en0): $lan  (dùng cho server.ip nếu client ở máy khác)"
  if docker_up && ct_running; then
    local mapped; mapped="$(docker port "$CT" 3306/tcp 2>/dev/null | head -1 | sed 's/.*://')"
    if [ -n "$mapped" ]; then
      [ "$mapped" = "$(cfg database.port)" ] && ok "database.port khớp cổng Docker ($mapped)" || fail "database.port=$(cfg database.port) nhưng container $CT mở cổng $mapped. Sửa lại cho khớp"
    fi
  fi
}

step5() {  # Chạy server
  hdr 5
  check_java
  check_config_exists || return
  [ -f "$SRC/20.jar" ] && ok "có SRC/20.jar" || fail "thiếu SRC/20.jar"
  [ -d "$SRC/data" ] && ok "có SRC/data/" || fail "thiếu SRC/data/"
  info "nhớ: phải 'cd SRC' trước khi chạy java -jar (server đọc Config.properties và data/ theo đường dẫn tương đối)"
  local p; p="$(cfg server.port)"; p="${p:-14445}"
  if port_used "$p"; then fail "cổng $p đang bị chiếm bởi $(port_owner "$p") (server đã chạy rồi, hoặc chương trình khác)"; else ok "cổng $p còn trống"; fi
  if check_db_reachable; then
    if docker_up && ct_running; then
      local t; t="$(dbq "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='$(cfg database.name)'")"
      if [ "$t" = "41" ]; then ok "DB $(cfg database.name) có 41 bảng"
      elif [ -z "$t" ]; then fail "đăng nhập DB bằng user/mật khẩu trong Config thất bại. Kiểm tra database.user và database.pass"
      else fail "DB $(cfg database.name) có $t bảng, cần 41 (làm lại Bước 3)"; fi
    else
      info "không có container $CT nên chưa kiểm tra được tài khoản và số bảng"
    fi
  fi
}

step6() {  # Tạo tài khoản
  hdr 6
  if ! (docker_up && ct_running); then warn "không có container $CT đang chạy, bạn tự kiểm tra bảng account bằng client DB của mình"; return; fi
  local n; n="$(dbq "SELECT COUNT(*) FROM $(cfg database.name).account")"
  if [ -z "$n" ]; then fail "không đọc được bảng account (chưa import dump hoặc sai mật khẩu)"; return; fi
  ok "bảng account đọc được, hiện có $n tài khoản"
  local adm; adm="$(dbq "SELECT GROUP_CONCAT(username) FROM $(cfg database.name).account WHERE is_admin=1")"
  [ -n "$adm" ] && warn "tài khoản admin hiện có: $adm. Dump có sẵn '1','11','111' mật khẩu 1 ký tự, nên đổi hoặc xoá"
  info "đặt username chưa tồn tại (cột username tối đa 20 ký tự). Kiểm tra: SELECT id FROM account WHERE username='ten_ban_chon';"
}

step7() {  # Chạy client
  hdr 7
  local p; p="$(cfg server.port)"; p="${p:-14445}"
  if port_used "$p"; then ok "server đang lắng nghe cổng $p"; else fail "server chưa chạy (cổng $p chưa mở). Làm Bước 5 trước"; fi
  local ip; ip="$(cfg server.ip)"
  case "$ip" in
    127.0.0.1|localhost) warn "server.ip=$ip: chỉ client chạy CÙNG máy Mac mới kết nối được. Client trong VM hoặc máy Windows khác cần IP LAN" ;;
    "") fail "server.ip trống" ;;
    *) local lan; lan="$(ipconfig getifaddr en0 2>/dev/null)"
       if [ -n "$lan" ] && [ "$ip" != "$lan" ]; then warn "server.ip=$ip khác IP LAN hiện tại của Mac ($lan). Client sẽ nhận sai địa chỉ"; else ok "server.ip=$ip"; fi ;;
  esac
  [ "$(uname -s)" = "Darwin" ] && warn "Mac không chạy trực tiếp XUNGLORDLOCAL.exe (Windows x86-64). Dùng VM Windows hoặc máy Windows khác"
  [ -f "$ROOT/LÂU CỒ MOD/XUNGLORDLOCAL.exe" ] && ok "có client XUNGLORDLOCAL.exe" || fail "thiếu LÂU CỒ MOD/XUNGLORDLOCAL.exe"
  info "địa chỉ server mà client dùng ban đầu chưa xác định được (xem mục 4.3 trong hướng dẫn)"
}

step8() {  # Console
  hdr 8
  local p; p="$(cfg server.port)"; p="${p:-14445}"
  if port_used "$p"; then ok "server đang chạy (pid: $(lsof -nP -iTCP:"$p" -sTCP:LISTEN -t 2>/dev/null | head -1))"; else fail "server chưa chạy"; fi
  [ "$(uname -s)" = "Darwin" ] && warn "lệnh 'run' và tự khởi động lại sau bảo trì dùng cmd.exe: không có trên Mac"
  info "lệnh 'bt' lưu dữ liệu và TẮT server. Đừng gõ khi có người đang chơi"
}

step9() {  # Build lại
  hdr 9
  command -v javac >/dev/null 2>&1 && ok "có javac: $(javac -version 2>&1)" || fail "không có javac (cần JDK 17+, không chỉ JRE)"
  [ -d "$SRC/src" ] && ok "có SRC/src" || fail "thiếu SRC/src"
  [ -f "$SRC/nbproject/project.xml" ] && ok "có SRC/nbproject (project NetBeans)" || fail "thiếu SRC/nbproject"
  [ -d "$SRC/lib" ] && ok "có SRC/lib ($(ls "$SRC/lib" | wc -l | tr -d ' ') jar)" || fail "thiếu SRC/lib"
  if port_used "$(cfg server.port)"; then warn "server đang chạy: tắt trước khi build để tránh ghi đè jar đang dùng"; fi
  [ -d "/Applications/Apache NetBeans.app" ] && ok "có Apache NetBeans" || warn "chưa thấy Apache NetBeans trong /Applications"
  [ -f "$SRC/20.jar" ] && info "nên sao lưu SRC/20.jar trước khi thay (cp SRC/20.jar SRC/20.jar.bak)"
}

if [ -n "$1" ]; then
  case "$1" in [1-9]) "step$1" ;; *) echo "Dùng: bash $(basename "$0") [1-9]"; exit 2 ;; esac
else
  for i in 1 2 3 4 5 6 7 8 9; do "step$i"; done
fi

printf "\n== KẾT QUẢ:  OK %d   Chú ý %d   Lỗi %d\n" "$OK" "$WARN" "$FAIL"
if [ "$FAIL" -gt 0 ]; then echo "   -> Có mục [LỖI]: sửa trước khi làm bước này."; exit 1
elif [ "$WARN" -gt 0 ]; then echo "   -> Đọc các mục [CHÚ Ý]; thường vẫn làm tiếp được."
else echo "   -> Sẵn sàng làm bước này."; fi
