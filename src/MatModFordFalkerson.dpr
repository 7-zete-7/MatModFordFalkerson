program MatModFordFalkerson;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Unit2 in 'Unit2.pas' {Form2};

{$E exe}

{$R *.res}
{$R bitmaps.res}

begin
  Application.Initialize;
  Application.Title := 'Математическое моделирование: Потоки в сетях';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
