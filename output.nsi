;--------------------------------
;General
!define MUI_PRODUCT "Calculator"
!define MUI_VERSION "1.0"
!define MUI_COMPANY "calculator"
!define MUI_SIZE "9000 KB"
!define MUI_URL "conatctus@Calculater.com"
!define MUI_HELPLINK "http://www.Calculater.com/"
!define MUI_FILE "calculator"
!define MUI_UNINSTALL "Uninstall"
!define MUI_BRANDINGTEXT "calculator 1.0"

!include "MUI2.nsh"
;--------------------------------

; The name of the installer
Name "setup"

; The file to write
OutFile "Setup.exe"

; The default installation directory
InstallDir $PROGRAMFILES\${MUI_PRODUCT}

; Request application privileges for Windows Vista
RequestExecutionLevel user
;--------------------------------
;Interface Settings

  !define MUI_ABORTWARNING
  !define MUI_ICON "calculator.ico"
  !define MUI_UNICON "calculator.ico"
  ;!define MUI_HEADERIMAGE "logo.ico"
  !define MUI_HEADERIMAGE_BITMAP ; optional
  !define MUI_WELCOMEFINISHPAGE_BITMAP "C:\Program Files (x86)\NSIS\Contrib\Graphics\Wizard\win.bmp"
  !define MUI_UNWELCOMEFINISHPAGE_BITMAP "C:\Program Files (x86)\NSIS\Contrib\Graphics\Wizard\win.bmp"
  !define MUI_COMPONENTSPAGE_SMALLDESC
  !define MUI_LANGDLL_ALLLANGUAGES
  !define MUI_FINISHPAGE_RUN "$INSTDIR\${MUI_FILE}.exe"
  
;--------------------------------
; Pages

  !insertmacro MUI_PAGE_WELCOME
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_INSTFILES
  !insertmacro MUI_PAGE_FINISH

  !insertmacro MUI_UNPAGE_WELCOME
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  !insertmacro MUI_UNPAGE_FINISH

;--------------------------------

; The stuff to install
Section "Installer" 
;create desktop shortcut
 CreateShortCut "$DESKTOP\${MUI_PRODUCT}.lnk" "$INSTDIR\${MUI_FILE}.exe" ""
 
;Create start-menu items
 CreateDirectory "$SMPROGRAMS\${MUI_PRODUCT}"
 CreateShortCut "$SMPROGRAMS\${MUI_PRODUCT}\Uninstall.lnk" "$INSTDIR\${MUI_UNINSTALL}.exe" "" "$INSTDIR\${MUI_UNINSTALL}.exe" 0
 CreateShortCut "$SMPROGRAMS\${MUI_PRODUCT}\${MUI_PRODUCT}.lnk" "$INSTDIR\${MUI_FILE}.exe" "" "$INSTDIR\${MUI_FILE}.exe" 0

;Write the uninstall key for windows
 WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\${MUI_PRODUCT}" "DisplayName" "${MUI_PRODUCT}"
 WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\${MUI_PRODUCT}" "Install_Dir" "$INSTDIR"
 WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\${MUI_PRODUCT}" "DisplayIcon" "$INSTDIR\calculater.ico"
 WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\${MUI_PRODUCT}" "DisplayVersion" "${MUI_VERSION}"
 WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\${MUI_PRODUCT}" "Publisher" "${MUI_COMPANY}" 
 WriteRegDWORD HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\${MUI_PRODUCT}" "EstimatedSize" "${MUI_SIZE}"
 WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\${MUI_PRODUCT}" "HelpLink" "${MUI_HELPLINK}" 
 WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\${MUI_PRODUCT}" "URLInfoAbout" "${MUI_URL}"
 WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\${MUI_PRODUCT}" "UninstallString" "$INSTDIR\${MUI_UNINSTALL}.exe"
 WriteRegDWORD HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\${MUI_PRODUCT}" "NoModify" 1
 WriteRegDWORD HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\${MUI_PRODUCT}" "NoRepair" 1
 
 WriteUninstaller "$INSTDIR\${MUI_UNINSTALL}.exe"
 
SectionEnd
;-----------------------------------

;Installer Sections
Section "Installer Section"

;Add files
  SetOutPath "$INSTDIR"
  File "${MUI_FILE}.exe"
  File "calculator.ico"
  ;File "Uninstall.exe"
  
SectionEnd ; end the section

;-----------------------------------------
;Language Selection Dialog Settings

  ;Remember the installer language
  !define MUI_LANGDLL_REGISTRY_ROOT "HKCU" 
  !define MUI_LANGDLL_REGISTRY_KEY "Software\Modern UI Test" 
  !define MUI_LANGDLL_REGISTRY_VALUENAME "Installer Language"

;Languages
 
  !insertmacro MUI_LANGUAGE "English" ; The first language is the default language

;--------------------------------
;Reserve Files
  
  ;If you are using solid compression, files that are required before
  ;the actual installation should be stored first in the data block,
  ;because this will make your installer start faster.
  
  !insertmacro MUI_RESERVEFILE_LANGDLL

;--------------------------------
;Descriptions

  ;Language strings
  LangString DESC_SecDummy ${LANG_ENGLISH} "A test section."

  ;Assign language strings to sections
  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${SecDummy} $(DESC_SecDummy)
  !insertmacro MUI_FUNCTION_DESCRIPTION_END

;--------------------------------
;Uninstall sections
Section "Uninstall"

;Delete files
 RMDir /r "$INSTDIR"
 
;remove the installation directory
 RMDir "$INSTDIR"

;Delete start-menu shortcut
 Delete "$DESKTOP\${MUI_PRODUCT}.lnk"
 Delete "$SMPROGRAMS\${MUI_PRODUCT}\*.*"
 RMDir "$SMPROGRAMS\${MUI_PRODUCT}" 
 Delete "$INSTDIR\${MUI_UNINSTALL}"
 
;Delete Uninstaller and uninstall registry entries
 DeleteRegKey HKLM "SOFTWARE\${MUI_PRODUCT}"
 DeleteRegKey HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\${MUI_PRODUCT}"
 
SectionEnd

;-----------------------------------
;MessageBox section

Function .onInstFailed
  MessageBox MB_OK "Better luck next time."
FunctionEnd

;Function .onInstSuccess
; MessageBox MB_OK "You have successfully installed ${MUI_PRODUCT}. Use the desktop icon to start the program."
;FunctionEnd

Function un.onUninstSuccess
 MessageBox MB_OK "You have successfully uninstalled ${MUI_PRODUCT}."
FunctionEnd