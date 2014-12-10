unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, ComCtrls, ExtCtrls, Buttons, Unit2;

type
  TForm1 = class(TForm)
    StringGrid1: TStringGrid;
    Panel1: TPanel;
    Edit1: TEdit;
    UpDown1: TUpDown;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    Edit2: TEdit;
    SpeedButton5: TSpeedButton;
    SpeedButton1: TSpeedButton;
    TrackBar1: TTrackBar;
    SpeedButton6: TSpeedButton;
    SaveDialog1: TSaveDialog;
    SpeedButton7: TSpeedButton;
    OpenDialog1: TOpenDialog;
    Panel2: TPanel;
    Label1: TLabel;
    SpeedButton8: TSpeedButton;
    Edit3: TEdit;
    CheckBox1: TCheckBox;
    SpeedButton9: TSpeedButton;
    Label2: TLabel;
    Label3: TLabel;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    procedure Panel1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure SpeedButton10Click(Sender: TObject);
    procedure SpeedButton11Click(Sender: TObject);
    procedure SpeedButton12Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TFile = record
    FTest: string[35];
    ii,jj: Integer;
    a: array[1..99] of array[1..99] of Integer;
  end;

function StrCatN2(const a,b: string): string;
function StrToIntN(const a: string): Integer;
function StrParseN(const a: string; const b: Integer = 1): string;
function IntToStrN(const a: Integer): string;

var
  Form1: TForm1;
  Fmas: array[1..99] of array[1..99] of array[1..99] of Integer;
  Cmas: Integer;
  Smas: Integer;

implementation

{$R *.dfm}

procedure TForm1.Panel1Click(Sender: TObject);
begin
  Self.Edit1.SetFocus;
  Self.Edit1.SelStart := 0;
  Self.Edit1.SelLength := 2;
end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if (Key <> #8) and ((Key < #48) or (Key > #57)) then
    Key := #0;
end;

procedure TForm1.Edit1Change(Sender: TObject);
var
  s: string;
begin
  with Self.Edit1 do
    begin
      s := Text;
      if s = '' then
        begin
          s := '2';
          SelStart := 1;
          SelLength := 10;
        end;
      if StrToInt(s) < 2 then
        begin
          s := '2';
          SelStart := 1;
          SelLength := 10;
        end;
      if StrToInt(s) > 99 then
        begin
          s := '99';  
          SelStart := 1;
          SelLength := 10;
        end;
      Text := IntToStr(StrToInt(s));
    end;
  Self.StringGrid1.RowCount := StrToInt(s) + 1;
  Self.StringGrid1.ColCount := StrToInt(s) + 1;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  Cmas := 0;
  Smas := 0;
  Self.TrackBar1.Min := 0;
  Self.TrackBar1.Max := 0;
  for i := 1 to 99 do
    begin
      Self.StringGrid1.Cells[0,i] := IntToStr(i);
      Self.StringGrid1.Cells[i,0] := IntToStr(i);
    end;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
var
  i, j, ii, jj: Integer;
  a: array[1..99] of array[1..99] of Integer;
  b: array[1..99] of string;
  c: Boolean;
begin
  Self.StringGrid1.Options := Self.StringGrid1.Options - [goEditing];
  Self.Panel1.Visible := False;
  if not Self.CheckBox1.Checked then
    begin
      Self.SpeedButton1.Enabled := True;
      Self.SpeedButton3.Enabled := True;
      Self.SpeedButton4.Enabled := True;
      Self.SpeedButton5.Enabled := True;
      Self.SpeedButton8.Visible := True;
      Self.SpeedButton6.Enabled := False;
      Self.SpeedButton7.Enabled := False;
      Self.Label3.Caption := IntToStrN(Cmas);
    end;

  ii := Self.StringGrid1.RowCount - 1;
  jj := Self.StringGrid1.ColCount - 1;
  for i := 1 to ii do
    for j := 1 to jj do
      a[i][j] := StrToIntN(Self.StringGrid1.Cells[i, j]);
  c := False;
  for i := 1 to ii do
    for j := 1 to jj do
      if a[i][j] <> Fmas[Smas][i][j] then
        c := True;
  if c then
    begin
      Cmas := Smas;
      Inc(Cmas);
      Smas := Cmas;
      Self.TrackBar1.Max := Cmas;
      Self.TrackBar1.Min := 1;
      Self.TrackBar1.Position := Smas;
      for i := 1 to ii do
        for j := 1 to jj do
          Fmas[Cmas][i][j] := a[i][j];
    end;
  for j := 2 to jj do
    b[j] := '0';
  b[1] := '*';
  c := True;
  while c do
    begin
      c := False;
      for j := 1 to jj do
        if b[j] <> '0' then
          for i := 1 to ii do
            if a[i][j] > 0 then
              if b[i] = '0' then
                begin
                  b[i] := IntToStr(j);
                  c := True;
                end;
      if b[jj] <> '0' then
        c := False;
    end;
  for j := 1 to jj do
    if b[j] <> '0' then
      begin
        Self.StringGrid1.Cells[j, 0] := StrCatN2(Self.StringGrid1.Cells[j, 0], b[j]);
      end;
end;

function StrCatN2(const a, b: string): string;
begin
  Result := a;
  if (Length(a) > 2) or (Length(b) > 2) then
    Exit;
  while Length(Result) < 2 do
    Result := Result + ' ';
  Result := Result + '|' + b;
end;

function StrParseN(const a: string; const b: Integer = 1): string;
var
  i, j: Integer;
  c: array[1..99] of string;
begin
  j := 1;
  c[j] := EmptyStr;
  for i := 1 to Length(a) do
    if (a[i] = '-') or (a[i] = '|') then
      begin
        Inc(j);
        c[j] := EmptyStr;
      end
    else
      c[j] := c[j] + a[i];
  Result := EmptyStr;
  for i := 1 to Length(c[b]) do
    if c[b][i] = ' ' then
      break
    else
      Result := Result + c[b][i];
end;

function StrToIntN(const a: string): Integer;
var
  b: string;
begin
  b := a;
  if (b = EmptyStr) or (b = '-') or (b = '+') then
    b := '0';
  if not (b[Length(b)] in ['0'..'9']) then
    b := Copy(b, 1, Length(b) - 1);
  Result := StrToInt(b);
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
var
  j,i,jj: Integer;
begin
  Self.SpeedButton1.Enabled := False;
  Self.SpeedButton3.Enabled := False;
  Self.SpeedButton4.Enabled := False;
  Self.SpeedButton5.Enabled := False;
  Self.Edit2.Text := '';
  Self.Edit3.Text := '';

  jj := Self.StringGrid1.ColCount;
  for j := 1 to jj do
    Self.StringGrid1.Cells[j, 0] := StrParseN(Self.StringGrid1.Cells[j, 0]);
  for i := 1 to jj do
    for j := 1 to jj do
      Self.StringGrid1.Cells[i, j] := IntToStrN(StrToIntN(Self.StringGrid1.Cells[i, j]));
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
var
  a, b: array[1..99] of string;
  c: array[1..100] of Integer;
  n, j, jj: Integer;
  s: string;
begin
  if Self.Edit2.Text <> EmptyStr then
    Exit;
  jj := Self.StringGrid1.ColCount - 1;
  for j := 1 to jj do
    b[j] := Self.StringGrid1.Cells[j, 0];
  n := 1;
  a[n] := b[jj];
  while StrParseN(a[n], 2) <> '*' do
    begin
      if StrParseN(a[n], 2) = EmptyStr then
        break;
      Inc(n);
      a[n] := b[StrToIntN(StrParseN(a[n - 1], 2))];
    end;

  j := 1;
  while a[j] <> EmptyStr do
    begin
      c[j] := StrToInt(StrParseN(a[j]));
      Inc(j);
    end;
  j := 2;
  c[100] := MaxInt;
  while a[j] <> EmptyStr do
    begin
      Self.StringGrid1.Cells[c[j], c[j - 1]] := Self.StringGrid1.Cells[c[j], c[j - 1]] + '+';
      Self.StringGrid1.Cells[c[j - 1], c[j]] := Self.StringGrid1.Cells[c[j - 1], c[j]] + '-';
      if StrToIntN(Self.StringGrid1.Cells[c[j - 1], c[j]]) < c[100] then
        c[100] := StrToIntN(Self.StringGrid1.Cells[c[j - 1], c[j]]);
      Inc(j);
    end;
  if c[100] <> MaxInt then
    Self.Edit3.Text := IntToStr(c[100]);

  if StrParseN(a[n], 2) <> EmptyStr then
    begin
      s := EmptyStr;
      for j := n downto 2 do
        s := s + StrParseN(a[j]) + '-';
      s := s + StrParseN(a[1]);
    end
  else
    s := 'Нет пути';
  Self.Edit2.Text := s;
end;

procedure TForm1.SpeedButton5Click(Sender: TObject);
var
  a: array[1..99] of string;
  b: array[1..99] of Integer;
  minb: Integer;
  j, jj: Integer;
  s: string;
begin
  s := Self.Edit2.Text;
  if s = 'Нет пути' then
    Exit;
  jj := 0;
  while StrParseN(s, jj + 1) <> EmptyStr do Inc(jj);
  for j := 1 to jj do
    a[j] := StrParseN(s, j);
  for j := 1 to jj do
    b[j] := StrToIntN(a[j]);
  for j := 1 to jj - 1 do
    b[j] := StrToIntN(Self.StringGrid1.Cells[b[j + 1], b[j]]);
  minb := b[1];
  for j := 2 to jj - 1 do
    if b[j] < minb then
      minb := b[j];
  for j := 1 to jj do
    b[j] := StrToIntN(a[j]);
  for j := 1 to jj - 1 do
    begin
      Self.StringGrid1.Cells[b[j + 1], b[j]] := IntToStrN(StrToIntN(Self.StringGrid1.Cells[b[j + 1], b[j]]) - minb);
      Self.StringGrid1.Cells[b[j], b[j + 1]] := IntToStrN(StrToIntN(Self.StringGrid1.Cells[b[j], b[j + 1]]) + minb);
    end;
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
var
  i, j, ii, jj: Integer;
begin
  if (Self.TrackBar1.Position = Smas) or ((Self.TrackBar1.Position = Cmas) and (Smas = Cmas)) then
    Exit;
  Smas := Self.TrackBar1.Position;
  ii := Self.StringGrid1.RowCount + 1;
  jj := Self.StringGrid1.ColCount + 1;
  for i := 1 to ii do
    for j := 1 to jj do
      Self.StringGrid1.Cells[i, j] := IntToStrN(Fmas[Smas][i][j]);
  if (Self.CheckBox1.Checked and (Self.TrackBar1.Position <> Self.TrackBar1.Max)) or not Self.CheckBox1.Checked then
    begin
      Self.SpeedButton3.Click;
      Self.SpeedButton2.Click;
      Self.SpeedButton4.Click;
    end;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
var
  i, j, ii, jj: Integer;
begin
  Self.SpeedButton1.Enabled := False;
  Self.SpeedButton2.Enabled := False;
  Self.SpeedButton3.Enabled := False;
  Self.SpeedButton4.Enabled := False;
  Self.SpeedButton5.Enabled := False;
  Self.SpeedButton9.Enabled := False;
  Self.SpeedButton11.Enabled := False;
  Self.SpeedButton12.Visible := True;
  Inc(Smas);
  Cmas := Smas;
  Self.CheckBox1.Checked := True;
  Self.TrackBar1.Min := 1;
  Self.TrackBar1.Max := Cmas;
  Self.TrackBar1.Position := Smas;
  ii := Self.StringGrid1.RowCount;
  jj := Self.StringGrid1.ColCount;
  for i := 1 to ii do
    for j := 1 to jj do
      Fmas[Smas][i][j] := Fmas[1][i][j] - Fmas[Smas-1][i][j];
  for i := 1 to ii do
    for j := 1 to jj do
      Self.StringGrid1.Cells[i, j] := IntToStrN(Fmas[Smas][i][j]);
end;

procedure TForm1.SpeedButton6Click(Sender: TObject);
var
  i, j: Integer;
  f: file of TFile;
  t: TFile;
  s: string;
begin
  if not Self.SaveDialog1.Execute then Exit;
  s := Self.SaveDialog1.FileName;
  t.FTest := 'MatModFF; Copyright 2014 7-zete-7;';
  t.ii := Self.StringGrid1.RowCount;
  t.jj := Self.StringGrid1.ColCount;
  for i := 1 to t.ii do
    for j := 1 to t.jj do
      t.a[i][j] := StrToIntN(Self.StringGrid1.Cells[i, j]);
  AssignFile(f, s);
  try
    ReWrite(f);
    Write(f, t);
  finally
    CloseFile(f);
  end;
end;

procedure TForm1.SpeedButton7Click(Sender: TObject);
var
  i, j: Integer;
  f: file of TFile;
  t: TFile;
  s: string;
begin
  if not Self.OpenDialog1.Execute then Exit;
  s := Self.OpenDialog1.FileName;
  AssignFile(f, s);
  try
    ReSet(f);
    Read(f, t);
  finally
    CloseFile(f);
  end;
  if t.FTest <> 'MatModFF; Copyright 2013 7-zete-7;' then
    begin
      ShowMessage('Неверный тип данных!');
      Exit;
    end;
  Self.Edit1.Text := IntToStr(t.ii - 1);
  for i := 1 to t.ii do
    for j := 1 to t.jj do
      Self.StringGrid1.Cells[i, j] := IntToStrN(t.a[i][j]);
end;

procedure TForm1.SpeedButton8Click(Sender: TObject);
begin
  with Self.StringGrid1 do Options := Options + [goEditing] + [goAlwaysShowEditor];
  Self.Panel1.Visible := True;
  Self.SpeedButton3.Click;
  Self.SpeedButton8.Visible := False;
  Self.SpeedButton6.Enabled := True;
  Self.SpeedButton7.Enabled := True;
  Self.SpeedButton2.Enabled := True;
  Self.SpeedButton9.Enabled := True;
  Self.SpeedButton11.Enabled := True;
  Self.SpeedButton12.Visible := False;
  Form2.Hide;
  Smas := 0;
  Cmas := 0;
  Self.CheckBox1.Checked := False;
  Self.TrackBar1.Min := 0;
  Self.TrackBar1.Max := 0;
  Self.Label3.Caption := IntToStrN(Cmas);
end;

function IntToStrN(const a: Integer): string;
begin
  if a <> 0 then
    Result := IntToStr(a)
  else
    Result := EmptyStr;
end;

procedure TForm1.SpeedButton9Click(Sender: TObject);
const
  n: Integer = 99;
var
  i: Integer;
begin
  Self.SpeedButton9.Enabled := False;
  Self.SpeedButton11.Enabled := False;
  i := 0;
  while (Self.Edit2.Text <> 'Нет пути') and (i <= n) do
    begin
      Sleep(100);
      Self.SpeedButton3.Click;
      Self.Repaint;
      Sleep(100);
      Self.SpeedButton2.Click;
      Self.Repaint;
      Sleep(100);
      Self.SpeedButton4.Click;
      Self.Repaint;
      Sleep(100);
      Self.SpeedButton5.Click;
      Self.Repaint;
      Sleep(100);
      Inc(i);
    end;
  if Self.Edit2.Text = 'Нет пути' then
    begin
      Sleep(100);
      Self.SpeedButton1.Click; 
      Self.Repaint;
      Self.SpeedButton12.Click;
    end;
end;

procedure TForm1.SpeedButton10Click(Sender: TObject);
begin
  ShowMessage('Автор:' + #10 + #13 + 'Квятковский Станислав Геннадьевич' + #10 + #13 + 'учащийся группы 22о' + #10 + #13 + 'Отделения "Информационные технологии"' + #10 + #13 + 'УО "Витебский государственный технологический колледж"');
end;

procedure TForm1.SpeedButton11Click(Sender: TObject);
begin       
      Sleep(100); 
      Self.SpeedButton5.Click;
      Self.Repaint;
      Sleep(100);
      Self.SpeedButton3.Click;
      Self.Repaint;
      Sleep(100);
      Self.SpeedButton2.Click;
      Self.Repaint;
      Sleep(100);
      Self.SpeedButton4.Click;
      Self.Repaint;
      Sleep(100);
end;

procedure TForm1.SpeedButton12Click(Sender: TObject);
var
  i, j, ii, s: Integer;
begin
  with Self.TrackBar1 do Position := Max;
  ii := Self.StringGrid1.RowCount - 1;
  Form2.Edit1.Text := '{';
  Form2.Edit2.Text := '{';
  for i := 1 to ii do
    if StrParseN(Self.StringGrid1.Cells[i, 0], 2) = EmptyStr then
      Form2.Edit2.Text := Form2.Edit2.Text + StrParseN(Self.StringGrid1.Cells[i, 0]) + '; '
    else
      Form2.Edit1.Text := Form2.Edit1.Text + StrParseN(Self.StringGrid1.Cells[i, 0]) + '; ';
  with Form2.Edit1 do Text := Copy(Text, 1, Length(Text) - 2) + '}';
  with Form2.Edit2 do Text := Copy(Text, 1, Length(Text) - 2) + '}';
  Form2.Edit3.Text := '{';
  for i := 1 to ii do
    if StrParseN(Self.StringGrid1.Cells[i, 0], 2) <> EmptyStr then
      for j := 1 to ii do
        if StrParseN(Self.StringGrid1.Cells[j, 0], 2) = EmptyStr then
          if Self.StringGrid1.Cells[i, j] <> EmptyStr then
            with Form2.Edit3 do Text := Text + '(' + StrParseN(Self.StringGrid1.Cells[i, 0]) + '; '+StrParseN(Self.StringGrid1.Cells[j, 0]) + '); ';
  with Form2.Edit3 do Text := Copy(Text, 1, Length(Text) - 2) + '}';
  Form2.Edit4.Text := '';
  for i := 1 to ii do
    if StrParseN(Self.StringGrid1.Cells[i, 0], 2) <> EmptyStr then
      for j := 1 to ii do
        if StrParseN(Self.StringGrid1.Cells[j, 0], 2) = EmptyStr then
          if Fmas[1][j][i] <> 0 then
            with Form2.Edit4 do Text := Text + '(' + IntToStr(Fmas[1][j][i]) + ')+';
  with Form2.Edit4 do Text := Copy(Text, 1, Length(Text) - 1) + '=';
  s := 0;
  for i := 1 to ii do
    if StrParseN(Self.StringGrid1.Cells[i, 0], 2) <> EmptyStr then
      for j := 1 to ii do
        if StrParseN(Self.StringGrid1.Cells[j, 0], 2) = EmptyStr then
          if Fmas[1][j][i] <> 0 then
            s := s + Fmas[1][j][i];
  with Form2.Edit4 do Text := Text + IntToStr(s);
  Form2.Show;
end;

end.
