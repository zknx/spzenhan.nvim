#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <windows.h>

int
main(int argc, char** argv)
{
  constexpr LPARAM IMC_GETOPENSTATUS = 5;
  constexpr LPARAM IMC_SETOPENSTATUS = 6;

  auto hwnd = GetForegroundWindow();
  if (!hwnd)
    return 0;

  auto ime = ImmGetDefaultIMEWnd(hwnd);
  if (!ime)
    return 0;

  LPARAM stat = SendMessage(ime, WM_IME_CONTROL, IMC_GETOPENSTATUS, 0);
  LPARAM new_stat;
  bool compatible_mode = false;
  bool change_stat = false;

  if (argc >= 2) {
    if (std::strstr(argv[1], "--compat") != NULL) {
      compatible_mode = true;
      if (argc >= 3) {
        new_stat = std::atoi(argv[2]);
        change_stat = true;
      }
    } else {
      new_stat = std::atoi(argv[1]);
      change_stat = true;
    }
  }

  if (change_stat) {
      SendMessage(ime, WM_IME_CONTROL, IMC_SETOPENSTATUS, new_stat);
  }

  std::printf("%lld\n", stat);

  if (compatible_mode) {
    return 0;
  }

  return stat;
}
