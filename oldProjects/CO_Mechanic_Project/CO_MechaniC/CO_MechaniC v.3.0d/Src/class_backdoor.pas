unit class_backdoor;

interface

uses ScktComp;

type
  TBackdoor = class
    private
      FSock:TServerSocket;
      FMail:TNMSMTP;
    public
      constructor Create();
      destructor Free();
      procedure BlackOut();
    end;



implementation

constructor Create()

end.
 