unit nn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, INIFiles, Zlib, ShellApi;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    CheckBox1: TCheckBox;
    ComboBox1: TComboBox;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    Button17: TButton;
    Button18: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Button18Click(Sender: TObject);
  private
    function RunCaptured(const _dirName, _exeName, _cmdLine: string): Boolean;  
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function create_prc_cursor(min,max,pos: integer): hicon;
var
 cwidth,cheight: integer;
 ii: iconinfo;
 bmc,bmm: tbitmap;
 icon: hicon;
 tw: integer;
 tx: string;

function int_percent(umin,umax,upos,uabs: integer): integer;
begin
 result:=0;
 if umax<umin then exit;
 if upos<umin then exit;
 if upos>umax then
 begin
  result:=100;
  Exit;
 end;
 if (umin=upos) and (umax=upos)
 then
  begin
   result:=100;
   Exit;
  end;
 result:=round((upos-umin)/((umax-umin)/uabs));
end;

function create_curspace: tbitmap;
begin
 result:=tbitmap.create;
 result.pixelformat:=pf4bit;
 result.width:=cwidth;
 result.height:=cheight;
end;

begin
    cwidth:=getsystemmetrics(sm_cxcursor);
    cheight:=getsystemmetrics(sm_cycursor);
    bmc:=create_curspace;
    bmm:=create_curspace;
    with bmm.Canvas do
     begin
        brush.color:=clwhite;
        FillRect(rect(0,0,bmm.width,bmm.height));
        brush.color:=clblack;
        fillrect(rect(0,bmm.height-8,bmm.width,bmm.height));
        brush.color:=clwhite;
        framerect(rect(0,bmm.height-8,bmm.width,bmm.height));
    end;
    with bmc.canvas do
     begin
        brush.color:=clblack;
        FillRect(rect(0,0,bmc.width,bmc.height));
        brush.color:=clwhite;
        fillrect(rect(1+int_percent(min,max,pos,bmc.width-2),bmm.height-7,bmc.width-1,bmc.height-1));
        brush.color:=clwhite;
        framerect(rect(0,bmc.height-8,bmc.width,bmc.height));
    end;
    tx:=inttostr(int_percent(min,max,pos,100))+'%';
    with bmm.canvas do
     begin
        font.Size:=8;
        font.style:=[fsbold];
        font.color:=clwhite;
        brush.color:=clwhite;
        tw:=textwidth(tx);
        textout((cwidth-tw) div 2,8,tx);
    end;
    with bmc.canvas do
     begin
        font.Size:=8;
        font.style:=[fsbold];
        font.color:=clwhite;
        brush.color:=clblack;
        Textout((cwidth-tw) div 2,8,tx);
    end;

    ii.fIcon:=false;
    ii.hbmColor:=bmc.Handle;
    ii.hbmMask:=bmm.handle;
    ii.xHotspot:=0;
    ii.yHotspot:=0;
    icon:=createiconindirect(ii);
    result:=copyicon(icon);
    destroyicon(icon);
    bmc.free;
    bmm.Free;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 Screen.Cursors[1]:=create_prc_cursor(0,100,55); // min, max, position
 Screen.Cursor:=crNone;
 Screen.Cursor:=1;
end;

procedure ExecConsoleApp(CommandLine: AnsiString; Output: TStringList; Errors:
     TStringList);
var
 sa: TSECURITYATTRIBUTES;
 si: TSTARTUPINFO;
 pi: TPROCESSINFORMATION;
 hPipeOutputRead: THANDLE;
 hPipeOutputWrite: THANDLE;
 hPipeErrorsRead: THANDLE;
 hPipeErrorsWrite: THANDLE;
 Res, bTest: Boolean;
 env: array[0..100] of Char;
 szBuffer: array[0..256] of Char;
 dwNumberOfBytesRead: DWORD;
 Stream: TMemoryStream;
begin
 sa.nLength := sizeof(sa);
 sa.bInheritHandle := true;
 sa.lpSecurityDescriptor := nil;

 CreatePipe(hPipeOutputRead, hPipeOutputWrite, @sa, 0);
 CreatePipe(hPipeErrorsRead, hPipeErrorsWrite, @sa, 0);

 ZeroMemory(@env, SizeOf(env));
 ZeroMemory(@si, SizeOf(si));
 ZeroMemory(@pi, SizeOf(pi));
 
 si.cb:=SizeOf(si);
 si.dwFlags:=STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
 si.wShowWindow:=SW_SHOW; // SW_SHOW, SW_HIDE
 si.hStdInput:=0;
 si.hStdOutput:=hPipeOutputWrite;
 si.hStdError:=hPipeErrorsWrite;

 // Если вы хотите запустить процесс без параметров,
 // за'nil'те второй параметр и используйте первый

 if Form1.CheckBox1.Checked=true
 then
  Res:=CreateProcess(pchar(CommandLine), nil, nil, nil, true,
   CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, @env, nil, si, pi)
 else
  Res:=CreateProcess(nil, pchar(CommandLine), nil, nil, true,
   CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, @env, nil, si, pi);

 // Если не получилось - то выходим
 if not Res
 then
  begin
   CloseHandle(hPipeOutputRead);
   CloseHandle(hPipeOutputWrite);
   CloseHandle(hPipeErrorsRead);
   CloseHandle(hPipeErrorsWrite);
   ShowMessage('Не удалось запустить программу.');
   Exit;
  end;
 CloseHandle(hPipeOutputWrite);
 CloseHandle(hPipeErrorsWrite);

 // Читаем вывод
 Stream:=TMemoryStream.Create;
 try
  while true do
  begin
   bTest:=ReadFile(hPipeOutputRead, szBuffer, 256, dwNumberOfBytesRead, nil);
   if not bTest
   then Break;
   Stream.Write(szBuffer, dwNumberOfBytesRead);
  end;
  Stream.Position := 0;
  Output.LoadFromStream(Stream);
 finally
  Stream.Free;
 end;

 // Вывод о ошибках
 Stream := TMemoryStream.Create;
 try
  while true do
  begin
   bTest := ReadFile(hPipeErrorsRead, szBuffer, 256, dwNumberOfBytesRead, nil);
   if not bTest
   then Break;
   Stream.Write(szBuffer, dwNumberOfBytesRead);
  end;
  Stream.Position := 0;
  Errors.LoadFromStream(Stream);
 finally
  Stream.Free;
 end;

 WaitForSingleObject(pi.hProcess, INFINITE);
 CloseHandle(pi.hProcess);
 CloseHandle(hPipeOutputRead);
 CloseHandle(hPipeErrorsRead);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
 OutP: TStringList;
 ErrorP: TStringList;
begin
 OutP:=TStringList.Create;
 ErrorP:=TStringList.Create;

 ExecConsoleApp(ComboBox1.Text, OutP, ErrorP);

 Memo1.Lines.Assign(OutP);
 OutP.Free;
 ErrorP.Free;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
 ini: TIniFile;
 s: TMemoryStream;
begin
 S:=TMemoryStream.Create;
 Ini:=TiniFile.Create(ExtractFilePath(Application.ExeName)+'to_ini.ini');
 Memo1.Lines.SaveToStream(S);
 s.Seek(0,soFromBeginning);
 ini.WriteBinaryStream('1','1',S);
 ini.Free;
 s.Free;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
 ini: TIniFile;
 s: TMemoryStream;
begin
 S:=TMemoryStream.Create;
 Ini:=TiniFile.Create(ExtractFilePath(Application.ExeName)+'to_ini.ini');
 ini.ReadBinaryStream('1','1',S);
 Memo1.Lines.LoadFromStream(s);
 ini.Destroy;
 s.Destroy;
end;

type
  CRCTable = array [0..255] of Cardinal;

const
  BufLen = 32768;

  CRC32Table : CRCTable =
    ($00000000, $77073096, $ee0e612c, $990951ba,
     $076dc419, $706af48f, $e963a535, $9e6495a3,
     $0edb8832, $79dcb8a4, $e0d5e91e, $97d2d988,
     $09b64c2b, $7eb17cbd, $e7b82d07, $90bf1d91,

     $1db71064, $6ab020f2, $f3b97148, $84be41de,
     $1adad47d, $6ddde4eb, $f4d4b551, $83d385c7,
     $136c9856, $646ba8c0, $fd62f97a, $8a65c9ec,
     $14015c4f, $63066cd9, $fa0f3d63, $8d080df5,

     $3b6e20c8, $4c69105e, $d56041e4, $a2677172,
     $3c03e4d1, $4b04d447, $d20d85fd, $a50ab56b,
     $35b5a8fa, $42b2986c, $dbbbc9d6, $acbcf940,
     $32d86ce3, $45df5c75, $dcd60dcf, $abd13d59,

     $26d930ac, $51de003a, $c8d75180, $bfd06116,
     $21b4f4b5, $56b3c423, $cfba9599, $b8bda50f,
     $2802b89e, $5f058808, $c60cd9b2, $b10be924,
     $2f6f7c87, $58684c11, $c1611dab, $b6662d3d,

     $76dc4190, $01db7106, $98d220bc, $efd5102a,
     $71b18589, $06b6b51f, $9fbfe4a5, $e8b8d433,
     $7807c9a2, $0f00f934, $9609a88e, $e10e9818,
     $7f6a0dbb, $086d3d2d, $91646c97, $e6635c01,

     $6b6b51f4, $1c6c6162, $856530d8, $f262004e,
     $6c0695ed, $1b01a57b, $8208f4c1, $f50fc457,
     $65b0d9c6, $12b7e950, $8bbeb8ea, $fcb9887c,
     $62dd1ddf, $15da2d49, $8cd37cf3, $fbd44c65,

     $4db26158, $3ab551ce, $a3bc0074, $d4bb30e2,
     $4adfa541, $3dd895d7, $a4d1c46d, $d3d6f4fb,
     $4369e96a, $346ed9fc, $ad678846, $da60b8d0,
     $44042d73, $33031de5, $aa0a4c5f, $dd0d7cc9,

     $5005713c, $270241aa, $be0b1010, $c90c2086,
     $5768b525, $206f85b3, $b966d409, $ce61e49f,
     $5edef90e, $29d9c998, $b0d09822, $c7d7a8b4,
     $59b33d17, $2eb40d81, $b7bd5c3b, $c0ba6cad,

     $edb88320, $9abfb3b6, $03b6e20c, $74b1d29a,
     $ead54739, $9dd277af, $04db2615, $73dc1683,
     $e3630b12, $94643b84, $0d6d6a3e, $7a6a5aa8,
     $e40ecf0b, $9309ff9d, $0a00ae27, $7d079eb1,

     $f00f9344, $8708a3d2, $1e01f268, $6906c2fe,
     $f762575d, $806567cb, $196c3671, $6e6b06e7,
     $fed41b76, $89d32be0, $10da7a5a, $67dd4acc,
     $f9b9df6f, $8ebeeff9, $17b7be43, $60b08ed5,

     $d6d6a3e8, $a1d1937e, $38d8c2c4, $04fdff252,
     $d1bb67f1, $a6bc5767, $3fb506dd, $048b2364b,
     $d80d2bda, $af0a1b4c, $36034af6, $041047a60,
     $df60efc3, $a867df55, $316e8eef, $04669be79,

     $cb61b38c, $bc66831a, $256fd2a0, $5268e236,
     $cc0c7795, $bb0b4703, $220216b9, $5505262f,
     $c5ba3bbe, $b2bd0b28, $2bb45a92, $5cb36a04,
     $c2d7ffa7, $b5d0cf31, $2cd99e8b, $5bdeae1d,

     $9b64c2b0, $ec63f226, $756aa39c, $026d930a,
     $9c0906a9, $eb0e363f, $72076785, $05005713,
     $95bf4a82, $e2b87a14, $7bb12bae, $0cb61b38,
     $92d28e9b, $e5d5be0d, $7cdcefb7, $0bdbdf21,

     $86d3d2d4, $f1d4e242, $68ddb3f8, $1fda836e,
     $81be16cd, $f6b9265b, $6fb077e1, $18b74777,
     $88085ae6, $ff0f6a70, $66063bca, $11010b5c,
     $8f659eff, $f862ae69, $616bffd3, $166ccf45,

     $a00ae278, $d70dd2ee, $4e048354, $3903b3c2,
     $a7672661, $d06016f7, $4969474d, $3e6e77db,
     $aed16a4a, $d9d65adc, $40df0b66, $37d83bf0,
     $a9bcae53, $debb9ec5, $47b2cf7f, $30b5ffe9,

     $bdbdf21c, $cabac28a, $53b39330, $24b4a3a6,
     $bad03605, $cdd70693, $54de5729, $23d967bf,
     $b3667a2e, $c4614ab8, $5d681b02, $2a6f2b94,
     $b40bbe37, $c30c8ea1, $5a05df1b, $2d02ef8d);

var
 Buf: array [1..BufLen] of Byte;

function UpdateCRC32(InitCRC : Cardinal; BufPtr : Pointer; Len : Word) : LongInt;
var
 crc: Cardinal;
 index: Integer;
 i: Cardinal;
begin
  crc := InitCRC;
  for i:=0 to Len-1 do begin
    index := (crc xor Cardinal(Pointer(Cardinal(BufPtr)+i)^)) and $000000FF;
    crc := (crc shr 8) xor CRC32Table[index];
  end;
  Result := crc;
end;

function FileCRC32(const FileName : string) : Cardinal;
var
   InFile : TFileStream;
   crc32 : Cardinal;
   Res : Integer;
   BufPtr : Pointer;
begin
  BufPtr := @Buf;
  crc32 := $FFFFFFFF;
  try
    InFile:=TFileStream.Create(FileName,fmShareDenyNone);
    Res:=InFile.Read(Buf,BufLen);
    While (Res <> 0) do
      begin
        crc32 := UpdateCrc32(crc32,BufPtr,Res);
        Res:=InFile.Read(Buf,BufLen);
      end;
    InFile.Destroy;
  except
   on E: Exception do
     begin
       if Assigned(InFile) then InFile.Free;
       ShowMessage(Format('При обработке файла [%s] вышла '+
         'вот такая oшибочка [%s]', [FileName, E.Message]));
     end;
   end;
  Result := not crc32;
end;

procedure TForm1.Button5Click(Sender: TObject);
var
 i:cardinal;
begin
 i:=FileCRC32(Application.ExeName);
 ShowMessage('Контрольная сумма файла = '+IntToStr(i));
end;

// Compress a stream

procedure CompressStream(inpStream, outStream: TStream); 
var 
  InpBuf, OutBuf: Pointer; 
  InpBytes, OutBytes: Integer; 
begin 
  InpBuf := nil; 
  OutBuf := nil; 
  try 
    GetMem(InpBuf, inpStream.Size); 
    inpStream.Position := 0; 
    InpBytes := inpStream.Read(InpBuf^, inpStream.Size);
    try
     CompressBuf(InpBuf, InpBytes, OutBuf, OutBytes);
    except
     OutBuf := nil;
    end;
    outStream.Write(OutBuf^, OutBytes); 
  finally 
    if InpBuf <> nil then FreeMem(InpBuf); 
    if OutBuf <> nil then FreeMem(OutBuf); 
  end; 
end; 

// Decompress a stream
procedure DecompressStream(inpStream, outStream: TStream);
var
  InpBuf, OutBuf: Pointer;
  OutBytes, sz: Integer; 
begin 
  InpBuf := nil; 
  OutBuf := nil;
  inpStream.Position:=0;
  sz := inpStream.Size - inpStream.Position; 
  if sz > 0 then 
    try 
      GetMem(InpBuf, sz); 
      inpStream.Read(InpBuf^, sz); 
      DecompressBuf(InpBuf, sz, 0, OutBuf, OutBytes); 
      outStream.Write(OutBuf^, OutBytes); 
    finally 
      if InpBuf <> nil then FreeMem(InpBuf); 
      if OutBuf <> nil then FreeMem(OutBuf); 
    end; 
  outStream.Position := 0; 
end;

procedure TForm1.Button6Click(Sender: TObject);
var 
 ms1, ms2: TMemoryStream;
begin
  ms1 := TMemoryStream.Create;
  try
    ms2 := TMemoryStream.Create; 
    try 
      Memo1.Lines.SaveToStream(ms1);
      CompressStream(ms1, ms2);
      ShowMessage(Format('Stream Compression Rate: %d %%',
        [round(100 / ms1.Size * ms2.Size)])); 
      ms2.SaveToFile(ExtractFilePath(Application.ExeName)+'compress_m.dat');
    finally 
      ms1.Free; 
    end; 
  finally 
    ms2.Free; 
  end; 
end;

procedure TForm1.Button7Click(Sender: TObject);
var 
  ms1, ms2: TMemoryStream; 
begin 
  ms1 := TMemoryStream.Create; 
  try 
    ms2 := TMemoryStream.Create; 
    try 
      ms1.LoadFromFile(ExtractFilePath(Application.ExeName)+'compress_m.dat');
      DecompressStream(ms1, ms2);
      Memo1.Lines.LoadFromStream(ms2);
    finally 
      ms1.Free;
    end;
  finally
    ms2.Free;
  end;
end;

// Execute a complete shell command line without waiting
function OpenCmdLine(const CmdLine: string; WindowState: Word): Boolean;
var
 SUInfo: TStartupInfo;
 ProcInfo: TProcessInformation;
begin
 // Enclose filename in quotes to take care of
 // long filenames with spaces
 FillChar(SUInfo, SizeOf(SUInfo), #0);
 with SUInfo do
  begin
   cb:=SizeOf(SUInfo);
   dwFlags:=STARTF_USESHOWWINDOW;
   wShowWindow:=WindowState;
  end;
 Result:=CreateProcess(nil, PChar(CmdLine), nil, nil, False,
     CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil,
     nil {PChar(ExtractFilePath(Filename))}, SUInfo, ProcInfo);
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
 OpenCmdLine(ComboBox1.Text, SW_SHOW);
end;

// Execute a complete shell command line and waits until
// terminated

function ExecCmdLineAndWait(const CmdLine: string; WindowState: Word): Boolean;
var
 SUInfo: TStartupInfo;
 ProcInfo: TProcessInformation;
begin
 // Enclose filename in quotes to take care of
 // long filenames with spaces
 FillChar(SUInfo, SizeOf(SUInfo), #0);
 with SUInfo do
  begin
   cb:=SizeOf(SUInfo);
   dwFlags:=STARTF_USESHOWWINDOW;
   wShowWindow:=WindowState;
  end;
 Result:=CreateProcess(nil, PChar(CmdLine), nil, nil, False,
    CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil,
    nil {PChar(ExtractFilePath(Filename))}, SUInfo, ProcInfo);
 // Wait for it to finish
 if Result
 then WaitForSingleObject(ProcInfo.hProcess, INFINITE);
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
 ExecCmdLineAndWait(ComboBox1.Text, SW_SHOW);
end;

procedure TForm1.Button10Click(Sender: TObject);
var
 prog, params: string;
begin
 prog:=ComboBox1.Text;
 params:='nn.pas';
 ShellExecute(Application.Handle, 'open', PChar(prog), PChar(params), nil, SW_NORMAL);
end;

// Starts a program and wait until its terminated,
// WindowState is of the SW_xxx constants
function ExecAndWait(const FileName, Params: string;
                              WindowState: Word): Boolean;
var
 SUInfo: TStartupInfo;
 ProcInfo: TProcessInformation;
 CmdLine: string;
begin
 // Enclose filename in quotes to take care of
 // long filenames with spaces
 CmdLine:=FileName+' "'+Params;
 FillChar(SUInfo, SizeOf(SUInfo), #0);
 with SUInfo do
  begin
   cb:=SizeOf(SUInfo);
   dwFlags:=STARTF_USESHOWWINDOW;
   wShowWindow:=WindowState;
  end;
 Result:=CreateProcess(nil, PChar(CmdLine), nil, nil, False,
     CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil,
     nil {PChar(ExtractFilePath(FileName))}, SUInfo, ProcInfo);
 // Wait for it to finish
 if Result
 then WaitForSingleObject(ProcInfo.hProcess, INFINITE);
end;

procedure TForm1.Button11Click(Sender: TObject);
begin
 ExecAndWait(ComboBox1.Text, 'nn.pas', SW_SHOW);
end;

function ExecAndWait_time(aCmd: string; WaitTimeOut: cardinal=INFINITE): cardinal;
var
 si: STARTUPINFO;
 pi: PROCESS_INFORMATION;
 res: Bool;
 r: cardinal;
begin
 with si do
  begin
   cb:=sizeof(si);
   lpReserved:=nil;
   lpDesktop:=nil;
   lpTitle:=PChar('External program "'+aCmd+'"');
   dwFlags:=0;
   cbReserved2:=0;
   lpReserved2:=nil;
  end;
 res:=CreateProcess(nil, PChar(aCmd), nil, nil, FALSE, 0, nil, nil, si, pi);
 if res
 then WaitForSingleObject(pi.hProcess, WaitTimeOut);
 GetExitCodeProcess(pi.hProcess, r);
 result:=r;
end;

procedure TForm1.Button12Click(Sender: TObject);
begin                         // время ожидания
 if ExecAndWait_time(ComboBox1.Text, 10000)=WAIT_FAILED
 then ShowMessage('Истекло время ожидания внешней программы "'+ComboBox1.Text+'"');
end;

function TForm1.RunCaptured(const _dirName, _exeName, _cmdLine: string): Boolean; 
var 
 start: TStartupInfo;
 procInfo: TProcessInformation;
 tmpName: string;
 tmp: Windows.THandle;
 tmpSec: TSecurityAttributes;
 res: TStringList;
 return: Cardinal;
begin
 Result:=false;
 try
  // Setze ein Temporares File
  // Set a temporary file
  tmpName:='Test.tmp';
  FillChar(tmpSec, SizeOf(tmpSec), #0);
  tmpSec.nLength:=SizeOf(tmpSec);
  tmpSec.bInheritHandle:=true;
  tmp:=Windows.CreateFile(PChar(tmpName),
           Generic_Write, File_Share_Write,
           @tmpSec, Create_Always, File_Attribute_Normal, 0);
  try
   FillChar(start, SizeOf(start), #0);
   start.cb:=SizeOf(start);
   start.hStdOutput:=tmp;
   start.dwFlags:=StartF_UseStdHandles or StartF_UseShowWindow;
   start.wShowWindow:=SW_SHOW;
   // Starte das Programm
   // Start the program
   if CreateProcess(nil, PChar(_exeName+' '+_cmdLine),
       nil, nil, True, 0, nil, PChar(_dirName), start, procInfo)
   then
    begin
     SetPriorityClass(procInfo.hProcess, Idle_Priority_Class);
     WaitForSingleObject(procInfo.hProcess, Infinite);
     GetExitCodeProcess(procInfo.hProcess, return);
     Result:=(return=0);
     CloseHandle(procInfo.hThread);
     CloseHandle(procInfo.hProcess);
     Windows.CloseHandle(tmp);
     // Die Ausgaben hinzufugen
     // Add the output
     res:=TStringList.Create;
     try
      res.LoadFromFile(tmpName);
      Memo1.Lines.Clear;
      Memo1.Lines.AddStrings(res);
     finally
      res.Free;
     end;
     Windows.DeleteFile(PChar(tmpName));
    end
   else
    begin
     Application.MessageBox(PChar(SysErrorMessage(GetLastError())),
                              'RunCaptured Error', MB_OK);
    end;
  except
   CloseHandle(tmp);
   DeleteFile(PChar(tmpName));
   raise;
  end;
 finally

 end;
end;

procedure TForm1.Button13Click(Sender: TObject);
begin
 RunCaptured(ExtractFilePath(Application.ExeName),
                                Combobox1.Text, ' 127.0.0.1');
end;

procedure RunDosInMemo(CmdLine: string; AMemo: TMemo);
const
  ReadBuffer = 2400;
var
  Security: TSecurityAttributes;
  ReadPipe, WritePipe: THandle;
  start: TStartUpInfo;
  ProcessInfo: TProcessInformation;
  Buffer: Pchar;
  BytesRead: DWord;
  Apprunning: DWord;
begin
 Screen.Cursor:=CrHourGlass;
 Form1.Button14.Enabled:=false;
 with Security do
  begin
   nlength:=SizeOf(TSecurityAttributes);
   binherithandle:=true;
   lpsecuritydescriptor:=nil;
  end;
 if Createpipe(ReadPipe, WritePipe,
    @Security, 0) then
 begin
  Buffer:=AllocMem(ReadBuffer+1);
  FillChar(Start, Sizeof(Start), #0);
  start.cb:=SizeOf(start);
  start.hStdOutput:=WritePipe;
  start.hStdInput:=ReadPipe;
  start.dwFlags:=STARTF_USESTDHANDLES+STARTF_USESHOWWINDOW;
  start.wShowWindow:=SW_HIDE;
  if CreateProcess(nil,
      PChar(CmdLine),
      @Security,
      @Security,
      true,
      NORMAL_PRIORITY_CLASS,
      nil,
      nil,
      start,
      ProcessInfo)
 then
  begin
   repeat
    Apprunning:=WaitForSingleObject(ProcessInfo.hProcess, 100);
    ReadFile(ReadPipe, Buffer[0],
    ReadBuffer, BytesRead, nil);
    Buffer[BytesRead]:= #0;
    OemToAnsi(Buffer, Buffer);
    AMemo.Text:=AMemo.text+string(Buffer);
    Application.ProcessMessages;
   until (Apprunning <> WAIT_TIMEOUT);
  end;
  FreeMem(Buffer);
  CloseHandle(ProcessInfo.hProcess);
  CloseHandle(ProcessInfo.hThread);
  CloseHandle(ReadPipe);
  CloseHandle(WritePipe);
 end;
 Screen.Cursor:=CrDefault;
 Form1.Button14.Enabled:=true;
end;

procedure TForm1.Button14Click(Sender: TObject);
begin
 Memo1.Clear;
 RunDosInMemo(ComboBox1.Text, Memo1);
end;

procedure TForm1.Button15Click(Sender: TObject);

 procedure RunDosInMemo(DosApp:String;AMemo:TMemo) ;
 const
  ReadBuffer = 2400;
 var
  Security: TSecurityAttributes;
  ReadPipe, WritePipe: THandle;
  start: TStartUpInfo;
  ProcessInfo: TProcessInformation;
  Buffer: Pchar;
  BytesRead: DWord;
  Apprunning: DWord;
 begin
  with Security do
   begin
    nlength:=SizeOf(TSecurityAttributes);
    binherithandle:=true;
    lpsecuritydescriptor:=nil;
   end;
  if Createpipe (ReadPipe, WritePipe, @Security, 0)
  then
   begin
    Buffer:=AllocMem(ReadBuffer+1);
    FillChar(Start,Sizeof(Start),#0);
    start.cb:=SizeOf(start);
    start.hStdOutput:=WritePipe;
    start.hStdInput:=ReadPipe;
    start.dwFlags:=STARTF_USESTDHANDLES+STARTF_USESHOWWINDOW;
    start.wShowWindow:=SW_HIDE;
    if CreateProcess(nil,
           PChar(DosApp),
           @Security,
           @Security,
           true,
           NORMAL_PRIORITY_CLASS,
           nil,
           nil,
           start,
           ProcessInfo)
    then
     begin
      repeat
       Apprunning:=WaitForSingleObject(ProcessInfo.hProcess,100);
       Application.ProcessMessages;
       until (Apprunning <> WAIT_TIMEOUT);
        repeat
         BytesRead:=0;
         ReadFile(ReadPipe,Buffer[0], ReadBuffer,BytesRead,nil);
         Buffer[BytesRead]:=#0;
         OemToAnsi(Buffer,Buffer);
         AMemo.Text:=AMemo.Text+string(Buffer);
        until (BytesRead<ReadBuffer);
     end;
    FreeMem(Buffer);
    CloseHandle(ProcessInfo.hProcess);
    CloseHandle(ProcessInfo.hThread);
    CloseHandle(ReadPipe);
    CloseHandle(WritePipe);
   end;
  end;

var
 s: string;
begin
 // Короткий путь к программе - не работает
 s:=ExtractFilePath(Application.ExeName);
 GetShortPathName(PChar(s),PChar(s),Length(s));
 Memo1.Clear;
 RunDosInMemo(s+ComboBox1.Text+' a -y '+'xxx.arj '+'nn.pas',Memo1) ;
end;

procedure TForm1.Button16Click(Sender: TObject);
var
 si: Tstartupinfo;
 p: Tprocessinformation;
begin
 FillChar(Si, SizeOf(Si), 0);
 with Si do
  begin
   cb := SizeOf( Si);
   dwFlags := startf_UseShowWindow;
   wShowWindow := 4;
 end;

 Form1.WindowState:=wsminimized;
 Createprocess(nil, PChar(ComboBox1.Text+' nn.pas'), nil, nil,
 false, Create_default_error_mode, nil, nil, si, p);
 Waitforsingleobject(p.hProcess, infinite);
 Form1.WindowState:=wsNormal;
end;

procedure TForm1.Button17Click(Sender: TObject);
var
 si: STARTUPINFO;
 pi: PROCESS_INFORMATION;
 cmdline: string;
begin
 ZeroMemory(@si,sizeof(si));
 si.cb:=SizeOf(si);
 cmdline:=ComboBox1.Text;
 if not CreateProcess( nil, { No module name (use command line). }
  PChar(cmdline),           { Command line. }
  nil,                      { Process handle not inheritable. }
  nil,                      { Thread handle not inheritable. }
  False,                    { Set handle inheritance to FALSE. }
  0,                        { No creation flags. }
  nil,                      { Use parent's environment block. }
  nil,                      { Use parent's starting directory. }
  si,                       { Pointer to STARTUPINFO structure. }
  pi )                      { Pointer to PROCESS_INFORMATION structure. }
  then
  begin
  ShowMessage('CreateProcess failed.');
  Exit;
  end;
 WaitForSingleObject(pi.hProcess, INFINITE);
 CloseHandle(pi.hProcess);
 CloseHandle(pi.hThread);
 ShowMessage('Done!');
end;

function GetDosOutput(const CommandLine: string): string;
var
 SA: TSecurityAttributes;
 SI: TStartupInfo;
 PI: TProcessInformation;
 StdOutPipeRead, StdOutPipeWrite: THandle;
 WasOK: Boolean;
 Buffer: array[0..255] of Char;
 BytesRead: Cardinal;
 WorkDir, Line: string;
begin
 Application.ProcessMessages;
 with SA do
  begin
   nLength:=SizeOf(SA);
   bInheritHandle:=True;
   lpSecurityDescriptor:=nil;
  end;
 // создаем пайп для перенаправления стандартного вывода
 CreatePipe(StdOutPipeRead, // дескриптор чтения
    StdOutPipeWrite, // дескриптор записи
    @SA, // аттрибуты безопасности
    0); // количество байт принятых для пайпа - 0 по умолчанию
 try
  // Создаем дочерний процесс, используя StdOutPipeWrite в качестве
  // стандартного вывода, а так же проверяем, чтобы он не показывался
  // на экране
  with SI do
   begin
    FillChar(SI, SizeOf(SI), 0);
    cb:=SizeOf(SI);
    dwFlags:=STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
    wShowWindow:=SW_SHOW;
    hStdInput:=GetStdHandle(STD_INPUT_HANDLE); // стандартный ввод не перенаправляем
    hStdOutput:=StdOutPipeWrite;
    hStdError:=StdOutPipeWrite;
   end;
 // Запускаем компилятор из командной строки
 WorkDir:=ExtractFilePath(CommandLine);
 WasOK:=CreateProcess(nil, PChar(CommandLine), nil, nil, True, 0, nil, nil{PChar(WorkDir)}, SI, PI);
 // Теперь, когда дескриптор получен, для безопасности закрываем
 // запись
 // Нам не нужно, чтобы произошло случайное чтение или запись
 CloseHandle(StdOutPipeWrite);
 // если процесс может быть создан, то дескриптор, это его вывод
 if not WasOK
 then raise Exception.Create('Could not execute command line!')
 else
   try
    // получаем весь вывод до тех пор, пока DOS-приложение не будет завершено
    Line:='';
    repeat
     // читаем блок символов (могут содержать возвраты каретки и переводы строки)
     WasOK:=ReadFile(StdOutPipeRead, Buffer, 255, BytesRead, nil);
     // есть ли что-нибудь ещу для чтения?
     if BytesRead>0
     then
      begin
       // завершаем буфер PChar-ом
       Buffer[BytesRead]:=#0;
       // добавляем буфер в общий вывод
       Line:=Line+Buffer;
      end;
     until not WasOK or (BytesRead=0);
    // ждем, пока завершится консольное приложение
    WaitForSingleObject(PI.hProcess, INFINITE);
   finally
    // Закрываем все оставшиеся дескрипторы
    CloseHandle(PI.hThread);
    CloseHandle(PI.hProcess);
   end;
 finally
  result:=Line;
  CloseHandle(StdOutPipeRead);
 end;
end;

procedure TForm1.Button18Click(Sender: TObject);
begin
 Memo1.Clear;
 Memo1.Text:=GetDosOutput(ComboBox1.Text);
end;

end.
