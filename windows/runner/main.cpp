#include <flutter/dart_project.h>
#include <flutter/flutter_view_controller.h>
#include <windows.h>

#include "flutter_window.h"
#include "utils.h"

// Firebase
#include "firebase/app.h"

int APIENTRY wWinMain(_In_ HINSTANCE instance, _In_opt_ HINSTANCE prev,
        _In_ wchar_t *command_line, _In_ int show_command) {
// Attach to console when present (e.g., 'flutter run') or create a
// new console when running with a debugger.
if (!::AttachConsole(ATTACH_PARENT_PROCESS) && ::IsDebuggerPresent()) {
CreateAndAttachConsole();
}

// Initialize COM, so that it is available for use in the library and/or
// plugins.
::CoInitializeEx(nullptr, COINIT_APARTMENTTHREADED);

flutter::DartProject project(L"data");

std::vector<std::string> command_line_arguments =
        GetCommandLineArguments();

project.set_dart_entrypoint_arguments(std::move(command_line_arguments));

FlutterWindow window(project);
Win32Window::Point origin(10, 10);
Win32Window::Size size(1280, 720);
if (!window.Create(L"assistencia", origin, size)) {
return EXIT_FAILURE;
}
window.SetQuitOnClose(true);

// 🚀 Inicializa Firebase aqui, depois que a janela existe
firebase::AppOptions options;
options.set_app_id("1:1234567890:web:abcdef123456");   // pegue do google-services.json
options.set_api_key("SUA_API_KEY");
options.set_project_id("SEU_PROJECT_ID");
options.set_messaging_sender_id("1234567890");

firebase::App* app = firebase::App::Create(options);

// Usa o app (mesmo que seja só para pegar o nome, evita o warning)
std::string appName = app->name();
(void)appName; // evita "variável não usada"

::MSG msg;
while (::GetMessage(&msg, nullptr, 0, 0)) {
::TranslateMessage(&msg);
::DispatchMessage(&msg);
}

::CoUninitialize();
return EXIT_SUCCESS;
}


//#include <flutter/dart_project.h>
//#include <flutter/flutter_view_controller.h>
//#include <windows.h>
//
//#include "flutter_window.h"
//#include "utils.h"
//
//int APIENTRY wWinMain(_In_ HINSTANCE instance, _In_opt_ HINSTANCE prev,
//                      _In_ wchar_t *command_line, _In_ int show_command) {
//  // Attach to console when present (e.g., 'flutter run') or create a
//  // new console when running with a debugger.
//  if (!::AttachConsole(ATTACH_PARENT_PROCESS) && ::IsDebuggerPresent()) {
//    CreateAndAttachConsole();
//  }
//
//  // Initialize COM, so that it is available for use in the library and/or
//  // plugins.
//  ::CoInitializeEx(nullptr, COINIT_APARTMENTTHREADED);
//
//  flutter::DartProject project(L"data");
//
//  std::vector<std::string> command_line_arguments =
//      GetCommandLineArguments();
//
//  project.set_dart_entrypoint_arguments(std::move(command_line_arguments));
//
//  FlutterWindow window(project);
//  Win32Window::Point origin(10, 10);
//  Win32Window::Size size(1280, 720);
//  if (!window.Create(L"assistencia", origin, size)) {
//    return EXIT_FAILURE;
//  }
//  window.SetQuitOnClose(true);
//
//  ::MSG msg;
//  while (::GetMessage(&msg, nullptr, 0, 0)) {
//    ::TranslateMessage(&msg);
//    ::DispatchMessage(&msg);
//  }
//
//  ::CoUninitialize();
//  return EXIT_SUCCESS;
//}
