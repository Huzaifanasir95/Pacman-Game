;Name: Huzaifa Nasir
;Section: A
INCLUDE Irvine32.inc
INCLUDE macros.inc
.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode: DWORD

SetConsleTitle PROTO
BUFFER_SIZE = 501
BUFFER_SIZE2 = 501
TITLE MASM PlaySound						

includelib Winmm.lib

PlaySound PROTO,
        pszSound:PTR BYTE, 
        hmod:DWORD, 
        fdwSound:DWORD
.data
nameconsle db "PACMAN",0
ground BYTE "------------------------------------------------------------------------------------------------------------------------",0
ground1 BYTE "|",0ah,0
ground2 BYTE "|",0
coin BYTE   "......................................................................................................................",0
temp byte ?

stwall BYTE "___________________",0  ;19

strScore BYTE "Your score is: ",0
score BYTE 0
livesScore BYTE "Remaining Lives :",0
lives BYTE 3
yourName BYTE "Name: ",0

xPos BYTE 20
yPos BYTE 20

 xGhostPos1 BYTE 10   
 yGhostPos1 BYTE 2  
  ghostDirection1 BYTE 1 ; 1: Right, 2: Down, 3: Left, 4: Up


ghost1 BYTE 'G', 0

fruit1 BYTE '@',0

bool1 byte 0
wallBool1 byte 0

Fruitbool1 byte 0





xEnemy BYTE 95
yEnemy BYTE 5
xEnemy1 BYTE 55
yEnemy1 BYTE 12
xEnemy2 BYTE 15
yEnemy2 BYTE 22

xCoinPos BYTE ?
yCoinPos BYTE ?

inputChar BYTE ?



    pacmanMessage LABEL BYTE
    BYTE "                                                                          ", 0ah
    BYTE "                                                                          ", 0ah
    BYTE " .----------------.  .----------------.  .----------------.  .----------------.  .----------------.  .-----------------.", 0ah
    BYTE "| .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. |", 0ah
    BYTE "| |   ______     | || |      __      | || |     ______   | || | ____    ____ | || |      __      | || | ____  _____  | |", 0ah
    BYTE "| |  |_   __ \   | || |     /  \     | || |   .' ___  |  | || ||_   \  /   _|| || |     /  \     | || ||_   \|_   _| | |", 0ah
    BYTE "| |    | |__) |  | || |    / /\ \    | || |  / .'   \_|  | || |  |   \/   |  | || |    / /\ \    | || |  |   \ | |   | |", 0ah
    BYTE "| |    |  ___/   | || |   / ____ \   | || |  | |         | || |  | |\  /| |  | || |   / ____ \   | || |  | |\ \| |   | |", 0ah
    BYTE "| |   _| |_      | || | _/ /    \ \_ | || |  \ `.___.'\  | || | _| |_\/_| |_ | || | _/ /    \ \_ | || | _| |_\   |_  | |", 0ah
    BYTE "| |  |_____|     | || ||____|  |____|| || |   `._____.'  | || ||_____||_____|| || ||____|  |____|| || ||_____|\____| | |", 0ah
    BYTE "| |              | || |              | || |              | || |              | || |              | || |              | |",0ah
    BYTE "| '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' |",0ah
    BYTE " '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------' ",0ah
    BYTE "                                 Copyright (C) 2023  Huzaifa Nasir                       ", 0ah
    BYTE "                                                                                         ", 0ah
    BYTE "                                                                          ", 0ah

    BYTE 0
    menuMessage LABEL BYTE
    BYTE "                                 __  ___ ______ _   __ __  __", 0ah
    BYTE "                                     /  |/  // ____// | / // / / /", 0ah
    BYTE "                                    / /|_/ // __/  /  |/ // / / /", 0ah
    BYTE "                                   / /  / // /___ / /|  // /_/ / ", 0ah
    BYTE "                                  /_/  /_//_____//_/ |_/ \____/   ", 0ah
    BYTE "                                              ", 0ah
    BYTE "                                              ", 0ah
    BYTE "                                              ", 0ah
    BYTE "                                              ", 0ah

    StartMessage LABEL BYTE
   BYTE "                                ____ ______ ___    ___  ______", 0ah
   BYTE "                               / __//_  __// _ |  / _ \/_  __/", 0ah
   BYTE"                              _\ \   / /  / __ | / , _/ / /   ", 0ah
  BYTE"                             /___/  /_/  /_/ |_|/_/|_| /_/ ", 0ah

  Instruction LABEL BYTE
  BYTE"                            ____ _  __ ____ ______ ___   __  __ _____ ______ ____ ____   _  __", 0ah
  BYTE"                           /_ _// |/ // __//_  __// _ \ / / / // ___//_  __//  _// __ \ / |/ /", 0ah
 BYTE"                          _/ / /    /_\ \   / /  / , _// /_/ // /__   / /  _/ / / /_/ //    / ", 0ah
BYTE"                         /___//_/|_//___/  /_/  /_/|_| \____/ \___/  /_/  /___/ \____//_/|_/  ", 0ah
           
  exitMessage LABEL BYTE 
  BYTE"                         ____ _  __ ____ ______", 0ah
  BYTE"                        / __/| |/_//  _//_  __/", 0ah
  BYTE"                       / _/ _>  < _/ /   / /   ", 0ah
  BYTE"                      /___//_/|_|/___/  /_/ ", 0ah
  
  BYTE 0
  instmesssage LABEL BYTE
  BYTE"The goal is to control the Pacman character and collect as many points as possible.", 0ah
 BYTE" ",0ah
  BYTE"     Each coin collected adds to your score.",0ah
  BYTE" ",0ah
  BYTE"     Be cautious of the ground and walls. ",0ah
  BYTE" ",0ah
  BYTE"     Press Ecs to pause the game at any time",0ah
  BYTE" ",0ah
  BYTE"     Press X to exit the game at any time",0ah
  BYTE" ",0ah
  BYTE"     Use the following keys to control Pacman:", 0ah
  BYTE" ",0ah
BYTE"           W: Move Pacman up.", 0ah
BYTE"           S: Move Pacman down.", 0ah
BYTE"           A: Move Pacman left.", 0ah
BYTE"           D: Move Pacman right.", 0ah
BYTE" ",0ah
BYTE" ",0ah
BYTE" ",0ah

BYTE 0
pasueMessage LABEL BYTE
BYTE "                  ___   ____ ____ __  __ __  ___ ____",0ah
BYTE "                      / _ \ / __// __// / / //  |/  // __/",0ah
BYTE "                     / , _// _/ _\ \ / /_/ // /|_/ // _/",0ah
BYTE "                    /_/|_|/___//___/ \____//_/  /_//___/",0ah
BYTE " ",0ah
BYTE " ",0ah
BYTE"                         ____ _  __ ____ ______", 0ah
BYTE"                        / __/| |/_//  _//_  __/", 0ah
BYTE"                       / _/ _>  < _/ /   / /   ", 0ah
BYTE"                      /___//_/|_|/___/  /_/ ", 0ah

BYTE 0
askName LABEL BYTE 
BYTE "                ____ _  __ ______ ____ ___    __  __ ____   __  __ ___    _  __ ___    __  ___ ____", 0ah
BYTE"               / __// |/ //_  __// __// _ \   \ \/ // __ \ / / / // _ \  / |/ // _ |  /  |/  // __/", 0ah
BYTE "              / _/ /    /  / /  / _/ / , _/    \  // /_/ // /_/ // , _/ /    // __ | / /|_/ // _/  ", 0ah
BYTE"             /___//_/|_/  /_/  /___//_/|_|     /_/ \____/ \____//_/|_| /_/|_//_/ |_|/_/  /_//___/ ", 0ah
playerName BYTE 30 DUP (?)

BYTE 0

levelMessage LABEl BYTE 
BYTE"                          __     ______ _    __ ______ __    _____",0ah
BYTE"                              / /    / ____/| |  / // ____// /   / ___/",0ah
BYTE"                             / /    / __/   | | / // __/  / /    \__ \ ",0ah
BYTE"                            / /___ / /___   | |/ // /___ / /___ ___/ / ",0ah
BYTE"                           /_____//_____/   |___//_____//_____//____/  ",0ah
                                           
levelMessage1 LABEl BYTE
BYTE"             __    ____ _   __ ____ __     ___  ___",0ah
BYTE"            / /   / __/| | / // __// /    / _ \<  /",0ah
BYTE"           / /__ / _/  | |/ // _/ / /__  / // // / ",0ah
BYTE"          /____//___/  |___//___//____/  \___//_/ ",0ah
levelMessage2 LABEl BYTE
BYTE"         __    ____ _   __ ____ __     ___   ___ ",0ah
BYTE"        / /   / __/| | / // __// /    / _ \ |_  |",0ah
BYTE"       / /__ / _/  | |/ // _/ / /__  / // // __/ ",0ah
BYTE"      /____//___/  |___//___//____/  \___//____/ ",0ah
levelMessage3 LABEl BYTE
BYTE"      __    ____ _   __ ____ __     ___   ____",0ah
BYTE"     / /   / __/| | / // __// /    / _ \ |_  /",0ah
BYTE"    / /__ / _/  | |/ // _/ / /__  / // /_/_ < ",0ah
BYTE"   /____//___/  |___//___//____/  \___//____/ ",0ah
BYTE 0

endGameMessage LABEL BYTE
BYTE"         ____ _  __ ___    _____ ___    __  ___ ____",0ah
BYTE"             / __// |/ // _ \  / ___// _ |  /  |/  // __/",0ah
BYTE"            / _/ /    // // / / (_ // __ | / /|_/ // _/  ",0ah
BYTE"           /___//_/|_//____/  \___//_/ |_|/_/  /_//___/  ",0ah

BYTE 0
nameMessage BYTE "Name: ",0
BYTE 0
scoreMessage BYTE "Score:",0
BYTE 0
emptyline BYTE " ",0ah
BYTE 0
buffer BYTE BUFFER_SIZE DUP(?)
filename     BYTE "output.txt",0
fileHandle   HANDLE ?
stringLength DWORD ?
bytesWritten DWORD ?

BYTE 0

deviceConnect BYTE "DeviceConnect",0

SND_ALIAS    DWORD 00010000h
SND_RESOURCE DWORD 00040005h
SND_FILENAME DWORD 00020000h

file BYTE "D:\\pacman_beginning.wav",0

deviceConnect1 BYTE "DeviceConnect",0

SND_ALIAS1    DWORD 00010000h
SND_RESOURCE1 DWORD 00040005h
SND_FILENAME1 DWORD 00020000h

file1 BYTE "D:\\pacman_chomp.wav",0
deviceConnect2 BYTE "DeviceConnect",0

SND_ALIAS2    DWORD 00010000h
SND_RESOURCE2 DWORD 00040005h
SND_FILENAME2 DWORD 00020000h

file2 BYTE "D:\\pacman22.wav",0

deviceConnect3 BYTE "DeviceConnect",0

SND_ALIAS3    DWORD 00010000h
SND_RESOURCE3 DWORD 00040005h
SND_FILENAME3 DWORD 00020000h

file3 BYTE "D:\\pacman_death.wav",0

buffer2 BYTE BUFFER_SIZE2 DUP(?)
filename2     BYTE "outputScore.txt",0
fileHandle2   HANDLE ?
stringLength2 DWORD ?
bytesWritten2 DWORD ?






.code
main PROC
Invoke SetConsoleTitle, ADDR nameconsle
 INVOKE PlaySound, OFFSET deviceConnect2, NULL, SND_ALIAS2
  INVOKE PlaySound, OFFSET deviceConnect3, NULL, SND_ALIAS3
  INVOKE PlaySound, OFFSET deviceConnect1, NULL, SND_ALIAS1


 INVOKE PlaySound, OFFSET deviceConnect, NULL, SND_ALIAS
     INVOKE PlaySound, OFFSET file, NULL, 1
     


    
call DisplayPacmanScreen






mov edx,OFFSET filename
call CreateOutputFile
mov fileHandle,eax

mov edx,OFFSET askName
call WriteString
    
    
    mov ecx, SIZEOF playerName
    mov edx, OFFSET playerName
    call ReadString

    mov stringLength,eax
    mov eax,fileHandle
    mov edx,OFFSET playerName
    mov ecx,stringLength
    call WriteToFile
    mov bytesWritten,eax
    call closeFile

    
    call clrscr
call DisplayMenuScreen


   

pauseret:

LEVEL1:
    
    call Displayground 
    call createwalls
     mov eax,red
        call settextcolor
         mov dl,40
        mov dh,20
        call Gotoxy
        mov edx,OFFSET fruit1
        call writeString
        
         mov dl,95
        mov dh,18
        call Gotoxy
        mov edx,OFFSET fruit1
        call writeString

    JMP gameloop

    pauseret2:
    LEVEL2:
    call Displayground
    call createwalls2
     mov eax,cyan
        call settextcolor
         mov dl,40
        mov dh,20
        call Gotoxy
        mov edx,OFFSET fruit1
        call writeString
        
         mov dl,95
        mov dh,18
        call Gotoxy
        mov edx,OFFSET fruit1
        call writeString
    JMP gameloop2

    pauseret3:
    LEVEL3:
    call Displayground
    call createwalls3
     mov eax,cyan
        call settextcolor
         mov dl,40
        mov dh,20
        call Gotoxy
        mov edx,OFFSET fruit1
        call writeString
        
         mov dl,95
        mov dh,18
        call Gotoxy
        mov edx,OFFSET fruit1
        call writeString
         mov dl,15
        mov dh,23
        call Gotoxy
        mov edx,OFFSET fruit1
        call writeString
    JMP gameloop3



    gameLoop:
        

        INVOKE PlaySound, OFFSET file1, NULL, 1
        mov eax,white (black * 16)
        call SetTextColor

        
        mov dl,0
        mov dh,0
        call Gotoxy
        mov edx,OFFSET strScore
        call WriteString
        mov eax,red
        call SetTextColor

       
        mov al,score
        call WriteInt
        mov dh,0
        mov dl,50
        call Gotoxy
        mov eax,white
        call SetTextColor
        mov edx,OFFSET yourName
        call WriteString
        mov eax,red
        call SetTextColor
        mov edx,OFFSET playerName
        call writestring

        
        mov dl ,98
        mov dh,0
        call Gotoxy
        mov eax,white
        call SetTextColor
        mov edx,OFFSET livesScore
        call WriteString
        mov eax,red
        call SetTextColor
        mov al,lives
        call writeInt
        call DrawGhost
        call UpdateGhost 
        call DrawGhost
       
      
        ; get user key input:
        call ReadChar
        mov inputChar,al

        ; exit game if user types 'x':
        cmp inputChar,"x"
        je exitGame

        cmp inputChar,"w"
        je moveUp

        cmp inputChar,"s"
        je moveDown

        cmp inputChar,"a"
        je moveLeft

        cmp inputChar,"d"
        je moveRight
        
        cmp inputChar,27
        je pausemenu

        cmp inputChar ,"l"
        je levelMenu
        
       


         
        moveUp:
        mov bl,yGhostPos1
            cmp yPos,bl
            je checkghost
            JMP skipno
            checkghost:
            mov bl,xGhostPos1
            cmp xPos,bl
            jne skipno
            dec lives 
            cmp lives,0
            je exitgame

            skipno:
            cmp yPos,20
            je fruitcheck31
            JMP skipfruit31
            fruitcheck31:
            cmp xPos,40
            jne skipfruit31
            add score,10
            skipfruit31:

             cmp yPos,20
            je fruitcheck1
            JMP skipfruit1
            fruitcheck1:
            cmp xPos,40
            jne skipfruit1
            add score,10
            skipfruit1:

            cmp yPos,2
            je skip3
            cmp yPos,21
            je internalwall301
            cmp yPos,16
            je internalwall302
            cmp yPos,25
            je internalwall303
            cmp yPos,15
            je internalwall304
            cmp yPos,19
            je internalwall305
            cmp yPos,27
            je internalwall306
            cmp yPos,22
            je internalwall307
            cmp yPos,22
            je internalwall308
            cmp yPos,20
            je internalwall309
            cmp yPos,10
            je internalwall310
            cmp yPos,17
            je internalwalls311
            cmp yPos,25
            je internalwalls312
            mov bl,yPos
            cmp cl,yGhostPos1
            je ghostcheck


            JMP skip300
            ghostcheck:
            cmp bl,xGhostPos1
            je livesdec
            livesdec:
            dec lives 
            cmp lives,0
            jne skip300
            jmp exitgame
            JMP skip300
            internalwall301:
            cmp xPos,10
            je skip3
            JMP skip300
            internalwall302:
            cmp xPos,20
            je skip3
            JMP skip300
            internalwall303:
            cmp xPos,30
            je skip3
            JMP skip300

            internalwall304:
            cmp xPos,40
            je skip3
            JMP skip300

            internalwall305:
            cmp xPos,50
            je skip3
            JMP skip300
            internalwall306:
            cmp xPos,70
            je skip3
            JMP skip300
            internalwall307:
            cmp xPos,80
            je skip3
            JMP skip300
            internalwall308:
            cmp xPos,90
            je skip3
            JMP skip300
            internalwall309:
            cmp xPos,100
            je skip3
            JMP skip300
            internalwall310:
            mov ecx,19
            mov al,11
            l310:
            cmp xPos,al
            je skip3
            inc al
            loop l310
            JMP skip300
            internalwalls311:
            mov ecx,19
            mov al,31
            l311:
            cmp xPos,al
            je skip3
            inc al
            loop l311
            JMP skip300

            

            internalwalls312:
            mov ecx,19
            mov al,71
            l312:
            cmp xPos,al
            je skip3
            inc al
            loop l312
            JMP skip300

            internalwalls313:
            mov ecx,19
            mov al,101
            l313:
            cmp xPos,al
            je skip3
            inc al
            loop l313
            JMP skip300

            
            skip300:
            cmp yPos,20
            je fruitcheck
            cmp yPos,18
            je fruitcheck2
            jmp noskip
            fruitcheck:
            cmp xPos,40
            je addscore
            jmp noskip
            fruitcheck2:
            cmp xPos,95
            je addscore
            jmp noskip
            

            addscore:
            add score,10
            noskip:
            call UpdatePlayer
            dec yPos
            inc score
            skip3:
            cmp yEnemy,2
            je skip16
            call DrawPlayer
            
           
             
             
             
             JMP gameloop
            skip16:
           

            call DrawPlayer
           

        jmp gameLoop



        moveDown:
            mov bl,yGhostPos1
            cmp yPos,bl
            je checkghost12
            JMP skipno1
            checkghost12:
            mov bl,xGhostPos1
            cmp xPos,bl
            jne skipno1
            dec lives 
            cmp lives,0
            je exitgame

            skipno1:
                        cmp yPos,20
            je fruitcheck312
            JMP skipfruit312
            fruitcheck312:
            cmp xPos,40
            jne skipfruit312
            add score,10
            skipfruit312:

             cmp yPos,20
            je fruitcheck13
            JMP skipfruit13
            fruitcheck13:
            cmp xPos,40
            jne skipfruit13
            add score,10
            skipfruit13:

        cmp yPos,28
        je skip
            cmp yPos,5
            je internalwall401
            cmp yPos,9
            je internalwall402
            cmp yPos,8
            je internalwall403
            cmp yPos,7
            je internalwall404
            cmp yPos,3
            je internalwall405
            cmp yPos,11
            je internalwall406
            cmp yPos,14
            je internalwall407
            cmp yPos,12
            je internalwall408
            cmp yPos,13
            je internalwall409
            cmp yPos,4
            je internalwall410
             mov bl,yPos
            cmp cl,yGhostPos1
            je ghostcheck1


            JMP skip400
            ghostcheck1:
            cmp bl,xGhostPos1
            je livesdec2
            livesdec2:
            dec lives 
            cmp lives,0
            jne skip300
            jmp exitgame
            JMP skip400
            JMP skip400
            
            internalwall401:
            cmp xPos,10
            je skip
            JMP skip400
            internalwall402:
            cmp xPos,20
            je skip
            JMP skip400
            internalwall403:
            cmp xPos,30
            je skip
            JMP skip400

            internalwall404:
            cmp xPos,40
            je skip
            JMP skip400

            internalwall405:
            cmp xPos,50
            je skip
            JMP skip400
            internalwall406:
            cmp xPos,70
            je skip
            JMP skip400
            internalwall407:
            cmp xPos,80
            je skip4
            JMP skip400
            internalwall408:
            cmp xPos,90
            je skip
            JMP skip400
            internalwall409:
            cmp xPos,100
            je skip
            JMP skip400
            internalwall410:
            cmp xPos,110
            je skip
            JMP skip400

            skip400:
        call UpdatePlayer
     
        inc yPos 
        inc score
        skip:
        cmp yEnemy,28
        je skip21
     
        inc yEnemy
        call DrawPlayer
      
        JMP gameloop
        skip21:
        call DrawPlayer
       
        jmp gameLoop

        moveLeft:
            mov bl,xGhostPos1
            cmp xPos,bl
            je checkghost123
            JMP skipno123
            checkghost123:
            mov bl,yGhostPos1
            cmp yPos,bl
            jne skipno123
            dec lives 
            cmp lives,0
            je exitgame

            skipno123:
             
             cmp xPos,40
             je fruitcheck432
             JMP skipfruit432
             fruitcheck432:
             cmp yPos,20
             jne skipfruit432
             add score,10
             skipfruit432:

             cmp xPos,95
             je fruitcheck4321
             JMP skipfruit4321
             fruitcheck4321:
             cmp yPos,18
             jne skipfruit4321
             add score,10
             skipfruit4321:

             
        cmp xPos,1
        je skip2
        cmp xPos,11
        je internalwalls101
        cmp xPos,31
        je internalwalls102
        cmp xPos,51
        je internalwalls103
        cmp xPos,71
        je internalwalls104
        cmp xPos,91
        je internalwalls105
        cmp xPos,111
        je internalwalls106
        cmp xPos,21
        je internalwalls107
        cmp xPos,41
        je internalwalls108
        cmp xPos,101
        je internalwalls109
        cmp xPos,81
        je internalwalls110
         mov bl,xPos
            cmp cl,xGhostPos1
            je ghostcheck12


            JMP skip200
            ghostcheck12:
            cmp bl,yGhostPos1
            je livesdec3
            livesdec3:
            dec lives 
            cmp lives,0
            jne skip200
            jmp exitgame
            JMP skip200

         cmp xPos,40
            je fruitcheck3
            cmp xPos,20
            je fruitcheck4
            jmp noskip1
            fruitcheck3:
            cmp xPos,40
            je addscore1
            jmp noskip1
            fruitcheck4:
            cmp yPos,18
            je addscore1
            jmp noskip1
            

            addscore1:
            add score,10
            noskip1:
        
        JMP skip200

        internalwalls101:
        mov ecx,15
        mov al,6
        l200:
        cmp yPos,al
        je skip2
        inc al
        Loop l200
        JMP skip200
        internalwalls102:
        mov ecx,15
        mov al,10
        l201:
        cmp yPos,al
        je skip2
        inc al
        Loop l201
        JMP skip200
        internalwalls103:
        mov ecx,15
        mov al,4
        l202:
        cmp yPos,al
        je skip2
        inc al
        Loop l202
        JMP skip200
        internalwalls104:
        mov ecx,15
        mov al,12
        l203:
        cmp yPos,al
        je skip2
        inc al
        Loop l203
        JMP skip200
        internalwalls105:
        mov ecx,14
        mov al,13
        l204:
        cmp yPos,al
        je skip2
        inc al
        Loop l204
        JMP skip200
        internalwalls106:
        mov ecx,15
        mov al,5
        l205:
        cmp yPos,al
        je skip2
        inc al
        Loop l205
        JMP skip200
        internalwalls107:
        mov ecx,6
        mov al,10
        l206:
        cmp yPos,al
        je skip2
        inc al
        Loop l206
        JMP skip200
        internalwalls108:
        mov ecx,5
        mov al,10
        l207:
        cmp yPos,al
        je skip2
        inc al
        Loop l207
        JMP skip200
        internalwalls109:
        mov ecx,7
        mov al,15
        l208:
        cmp yPos,al
        je skip2
        inc al
        Loop l208
        JMP skip200
        internalwalls110:
        mov ecx,7
        mov al,15
        l209:
        cmp yPos,al
        je skip2
        inc al
        Loop l209

        skip200:
           
        call UpdatePlayer
     
        dec xPos
        inc score
        skip2:
        cmp xEnemy,1
        je skip12
     
        dec xEnemy
        
        call DrawPlayer
        
        skip12:
    
        call DrawPlayer
    
         
        jmp gameLoop



        moveRight:
             mov bl,xGhostPos1
            cmp xPos,bl
            je checkghost1234
            JMP skipno1234
            checkghost1234:
            mov bl,yGhostPos1
            cmp yPos,bl
            jne skipno1234
            dec lives 
            cmp lives,0
            je exitgame

            skipno1234:
             cmp xPos,40
             je fruitcheck4325
             JMP skipfruit4325
             fruitcheck4325:
             cmp yPos,20
             jne skipfruit4325
             add score,10
             skipfruit4325:

             cmp xPos,95
             je fruitcheck43215
             JMP skipfruit43215
             fruitcheck43215:
             cmp yPos,18
             jne skipfruit43215
             add score,10
             skipfruit43215:
        cmp xPos,118
        je skip4
        cmp xPos,9
        je internalwalls
        cmp xPos,29
        je internalwalls2
        cmp xPos,49
        je internalwalls3
        cmp xPos,69
        je internalwalls4
        cmp xPos,89
        je internalwalls5
        cmp xPos,109
        je internalwalls6
        cmp xPos,19
        je internalwalls7
        cmp xPos,39
        je internalwalls8
        cmp xPos,99
        je internalwalls9
        cmp xPos,79
        je internalwalls10
         mov bl,xPos
            cmp cl,xGhostPos1
            je ghostcheck123


            JMP skip100
            ghostcheck123:
            cmp bl,yGhostPos1
            je livesdec33
            livesdec33:
            dec lives 
            cmp lives,0
            jne skip100
            jmp exitgame
            JMP skip100
        JMP skip100
        internalwalls:
        mov ecx,15
        mov al,6
        l100:
        cmp yPos,al
        je skip4
        inc al
        Loop l100
        JMP skip100
        internalwalls2:
        mov ecx,15
        mov al,10
        l101:
        cmp yPos,al
        je skip4
        inc al
        Loop l101
        JMP skip100
        internalwalls3:
        mov ecx,15
        mov al,4
        l102:
        cmp yPos,al
        je skip4
        inc al
        Loop l102
        JMP skip100
        internalwalls4:
        mov ecx,15
        mov al,12
        l103:
        cmp yPos,al
        je skip4
        inc al
        Loop l103
        JMP skip100
        internalwalls5:
        mov ecx,14
        mov al,13
        l104:
        cmp yPos,al
        je skip4
        inc al
        Loop l104
        JMP skip100
        internalwalls6:
        mov ecx,15
        mov al,5
        l105:
        cmp yPos,al
        je skip4
        inc al
        Loop l105
        JMP skip100
        internalwalls7:
        mov ecx,6
        mov al,10
        l106:
        cmp yPos,al
        je skip4
        inc al
        Loop l106
        JMP skip100
        internalwalls8:
        mov ecx,5
        mov al,10
        l107:
        cmp yPos,al
        je skip4
        inc al
        Loop l107
        JMP skip100
        internalwalls9:
        mov ecx,7
        mov al,15
        l108:
        cmp yPos,al
        je skip4
        inc al
        Loop l108
        JMP skip100
        internalwalls10:
        mov ecx,7
        mov al,15
        l109:
        cmp yPos,al
        je skip4
        inc al
        Loop l109
        JMP skip100


        skip100:
        
        call UpdatePlayer
 
        inc xPos
        inc score
        skip4:
   
        cmp xEnemy,118
        je skip11
        inc xEnemy

        call DrawPlayer
   
        JMP gameloop
        skip11:
        call DrawPlayer
    
        jmp gameLoop

        pausemenu:
        call clrscr
        call DisplaypauseScreen
        JMP pauseret

        levelMenu:
        call clrscr
        call DisplayLevelScreen
        call ReadInt
        cmp eax,1
        je LEVEl1
        cmp eax,2
        je LEVEL2
        cmp eax,3
        je LEVEL3
        call exitGame




    jmp gameLoop

















        gameLoop2:
        
         INVOKE PlaySound, OFFSET file1, NULL, 1

        mov eax,white (black * 16)
        call SetTextColor

        ; draw score:
        mov dl,0
        mov dh,0
        call Gotoxy
        mov edx,OFFSET strScore
        call WriteString
        mov eax,red
        call SetTextColor

       
        mov al,score
        call WriteInt
        mov dh,0
        mov dl,50
        call Gotoxy
        mov eax,white
        call SetTextColor
        mov edx,OFFSET yourName
        call WriteString
        mov eax,red
        call SetTextColor
        mov edx,OFFSET playerName
        call writestring
        
        mov dl ,98
        mov dh,0
        call Gotoxy
        mov eax,white
        call SetTextColor
        mov edx,OFFSET livesScore
        call WriteString
        mov eax,red
        call SetTextColor
        mov al,lives
        call writeInt

        onGround2:

        ; get user key input:
        call ReadChar
        mov inputChar,al

        ; exit game if user types 'x':
        cmp inputChar,"x"
        je exitGame

        cmp inputChar,"w"
        je moveUp2

        cmp inputChar,"s"
        je moveDown2

        cmp inputChar,"a"
        je moveLeft2

        cmp inputChar,"d"
        je moveRight2
        
        cmp inputChar,27
        je pausemenu2

        cmp inputChar ,"l"
        je levelMenu2

 
        moveUp2:
                mov bl,yGhostPos1
            cmp yPos,bl
            je checkghost21
            JMP skipno21
            checkghost21:
            mov bl,xGhostPos1
            cmp xPos,bl
            jne skipno21
            dec lives 
            cmp lives,0
            je exitgame

            skipno21:
            cmp yPos,2
            je skip5
            cmp yPos,21
            je internalwall501
            cmp yPos,25
            je internalwall502
            cmp yPos,29
            je internalwall503
            cmp yPos,15
            je internalwall504
            cmp yPos,19
            je internalwall505
            cmp yPos,27
            je internalwall506
            cmp yPos,22
            je internalwall507
            cmp yPos,22
            je internalwall508
            cmp yPos,20
            je internalwall509
            cmp yPos,10
            je internalwall510
            cmp yPos,17
            je internalwalls511
            cmp yPos,25
            je internalwalls512
         
            

            JMP skip500
            internalwall501:
            cmp xPos,10
            je skip5
            JMP skip500
            internalwall502:
            cmp xPos,20
            je skip5
            JMP skip300
            internalwall503:
            cmp xPos,30
            je skip5
            JMP skip500

            internalwall504:
            cmp xPos,40
            je skip5
            JMP skip500

            internalwall505:
            cmp xPos,50
            je skip5
            JMP skip500
            internalwall506:
            cmp xPos,70
            je skip5
            JMP skip500
            internalwall507:
            cmp xPos,80
            je skip5
            JMP skip500
            internalwall508:
            cmp xPos,90
            je skip5
            JMP skip500
            internalwall509:
            cmp xPos,100
            je skip5
            JMP skip500
            internalwall510:
            mov ecx,19
            mov al,11
            l510:
            cmp xPos,al
            je skip5
            inc al
            loop l510
            JMP skip500
            internalwalls511:
            mov ecx,19
            mov al,31
            l511:
            cmp xPos,al
            je skip5
            inc al
            loop l511
            JMP skip500

            

            internalwalls512:
            mov ecx,19
            mov al,71
            l512:
            cmp xPos,al
            je skip5
            inc al
            loop l512
            JMP skip500

            internalwalls513:
            mov ecx,19
            mov al,101
            l513:
            cmp xPos,al
            je skip5
            inc al
            loop l513
            JMP skip500

            
            skip500:
            call UpdatePlayer
            dec yPos
            inc score
            skip5:
            cmp yEnemy,2
            je skip516
            call UpdateEnemy
             dec yEnemy
             
             call DrawEnemy
             call DrawPlayer
             JMP gameloop2
            skip516:
            call UpdateEnemy
            call DrawPlayer
            call DrawEnemy

        jmp gameLoop2



        moveDown2:
                    mov bl,yGhostPos1
            cmp yPos,bl
            je checkghost1232
            JMP skipno132
            checkghost1232:
            mov bl,xGhostPos1
            cmp xPos,bl
            jne skipno132
            dec lives 
            cmp lives,0
            je exitgame

            skipno132:
        cmp yPos,28
        je skip6
            cmp yPos,7
            je internalwall601
            cmp yPos,9
            je internalwall602
            cmp yPos,8
            je internalwall603
            cmp yPos,7
            je internalwall604
            cmp yPos,3
            je internalwall605
            cmp yPos,11
            je internalwall606
            cmp yPos,14
            je internalwall607
            cmp yPos,12
            je internalwall608
            cmp yPos,13
            je internalwall609
            cmp yPos,4
            je internalwall610
            
            JMP skip600
            
            internalwall601:
            cmp xPos,10
            je skip6
            JMP skip600
            internalwall602:
            cmp xPos,20
            je skip6
            JMP skip600
            internalwall603:
            cmp xPos,30
            je skip6
            JMP skip600

            internalwall604:
            cmp xPos,40
            je skip6
            JMP skip600

            internalwall605:
            cmp xPos,50
            je skip6
            JMP skip600
            internalwall606:
            cmp xPos,70
            je skip6
            JMP skip600
            internalwall607:
            cmp xPos,80
            je skip6
            JMP skip600
            internalwall608:
            cmp xPos,90
            je skip6
            JMP skip600
            internalwall609:
            cmp xPos,100
            je skip6
            JMP skip600
            internalwall610:
            cmp xPos,110
            je skip6
            JMP skip600

            skip600:
        call UpdatePlayer
        call UpdateEnemy
        inc yPos 
        inc score
        skip6:
        cmp yEnemy,28
        je skip621
        call UpdateEnemy
        inc yEnemy
        call DrawPlayer
        call DrawEnemy
        JMP gameloop2
        skip621:
        call DrawPlayer
        call DrawEnemy
        jmp gameLoop2

        moveLeft2:
                    mov bl,xGhostPos1
            cmp xPos,bl
            je checkghost12356
            JMP skipno12356
            checkghost12356:
            mov bl,yGhostPos1
            cmp yPos,bl
            jne skipno12356
            dec lives 
            cmp lives,0
            je exitgame

            skipno12356:
        cmp xPos,1
        je skip7
        cmp xPos,11
        je internalwalls701
        cmp xPos,31
        je internalwalls702
        cmp xPos,51
        je internalwalls703
        cmp xPos,71
        je internalwalls704
        cmp xPos,91
        je internalwalls705
        cmp xPos,111
        je internalwalls706
        cmp xPos,21
        je internalwalls707
        cmp xPos,41
        je internalwalls708
        cmp xPos,101
        je internalwalls709
        cmp xPos,81
        je internalwalls710
        cmp xPos,61
        je internalwalls711

        
        JMP skip700

        internalwalls701:
        mov ecx,15
        mov al,6
        l700:
        cmp yPos,al
        je skip7
        inc al
        Loop l700
        JMP skip700
        internalwalls702:
        mov ecx,29
        mov al,10
        l701:
        cmp yPos,al
        je skip7
        inc al
        Loop l701
        JMP skip700
        internalwalls703:
        mov ecx,15
        mov al,4
        l702:
        cmp yPos,al
        je skip7
        inc al
        Loop l702
        JMP skip700
        internalwalls704:
        mov ecx,15
        mov al,12
        l703:
        cmp yPos,al
        je skip7
        inc al
        Loop l703
        JMP skip700
        internalwalls705:
        mov ecx,16
        mov al,13
        l704:
        cmp yPos,al
        je skip7
        inc al
        Loop l704
        JMP skip700
        internalwalls706:
        mov ecx,15
        mov al,10
        l705:
        cmp yPos,al
        je skip7
        inc al
        Loop l705
        JMP skip700
        internalwalls707:
        mov ecx,16
        mov al,10
        l706:
        cmp yPos,al
        je skip7
        inc al
        Loop l706
        JMP skip700
        internalwalls708:
        mov ecx,5
        mov al,10
        l707:
        cmp yPos,al
        je skip7
        inc al
        Loop l707
        JMP skip700
        internalwalls709:
        mov ecx,7
        mov al,15
        l708:
        cmp yPos,al
        je skip7
        inc al
        Loop l708
        JMP skip700
        internalwalls710:
        mov ecx,7
        mov al,15
        l709:
        cmp yPos,al
        je skip7
        inc al
        Loop l709

        internalwalls711:
        mov ecx,15
        mov al,15
        l7090:
        cmp yPos,al
        je skip7
        inc al
        Loop l7090
        JMP skip700

        skip700:
        call UpdatePlayer
        call UpdateEnemy
        dec xPos
        inc score
        skip7:
        cmp xEnemy,1
        je skip712
        call UpdateEnemy
        dec xEnemy
        
        call DrawPlayer
        
        skip712:
        call UpdateEnemy
        call DrawPlayer
        call DrawEnemy
         
        jmp gameLoop2






        moveRight2:
                     mov bl,xGhostPos1
            cmp xPos,bl
            je checkghost123476
            JMP skipno123476
            checkghost123476:
            mov bl,yGhostPos1
            cmp yPos,bl
            jne skipno123476
            dec lives 
            cmp lives,0
            je exitgame

            skipno123476:
        cmp xPos,118
        je skip8
        cmp xPos,9
        je internalwalls801
        cmp xPos,29
        je internalwalls802
        cmp xPos,49
        je internalwalls803
        cmp xPos,69
        je internalwalls804
        cmp xPos,89
        je internalwalls805
        cmp xPos,109
        je internalwalls806
        cmp xPos,19
        je internalwalls807
        cmp xPos,39
        je internalwalls808
        cmp xPos,99
        je internalwalls809
        cmp xPos,79
        je internalwalls810
        JMP skip800
        internalwalls801:
        mov ecx,15
        mov al,6
        l800:
        cmp yPos,al
        je skip8
        inc al
        Loop l800
        JMP skip800
        internalwalls802:
        mov ecx,15
        mov al,10
        l801:
        cmp yPos,al
        je skip8
        inc al
        Loop l801
        JMP skip800
        internalwalls803:
        mov ecx,15
        mov al,4
        l802:
        cmp yPos,al
        je skip8
        inc al
        Loop l802
        JMP skip800
        internalwalls804:
        mov ecx,15
        mov al,12
        l803:
        cmp yPos,al
        je skip8
        inc al
        Loop l803
        JMP skip800
        internalwalls805:
        mov ecx,16
        mov al,13
        l804:
        cmp yPos,al
        je skip8
        inc al
        Loop l804
        JMP skip800
        internalwalls806:
        mov ecx,15
        mov al,5
        l805:
        cmp yPos,al
        je skip8
        inc al
        Loop l805
        JMP skip800
        internalwalls807:
        mov ecx,6
        mov al,10
        l806:
        cmp yPos,al
        je skip8
        inc al
        Loop l806
        JMP skip800
        internalwalls808:
        mov ecx,5
        mov al,10
        l807:
        cmp yPos,al
        je skip8
        inc al
        Loop l807
        JMP skip800
        internalwalls809:
        mov ecx,7
        mov al,15
        l808:
        cmp yPos,al
        je skip8
        inc al
        Loop l808
        JMP skip800
        internalwalls810:
        mov ecx,7
        mov al,15
        l809:
        cmp yPos,al
        je skip8
        inc al
        Loop l809
        JMP skip800


        skip800:
        
        call UpdatePlayer
        call UpdateEnemy
        inc xPos
        inc score
        skip8:
        call UpdateEnemy
        cmp xEnemy,118
        je skip8011
        inc xEnemy

        call DrawPlayer
        call DrawEnemy
        JMP gameloop2
        skip8011:
        call DrawPlayer
        call DrawEnemy
        jmp gameLoop2

        pausemenu2:
        call clrscr
        call DisplaypauseScreen
        JMP pauseret2

        levelMenu2:
        call clrscr
        call DisplayLevelScreen
        call ReadInt
        cmp eax,1
        je LEVEl1
        cmp eax,2
        je LEVEL2
        cmp eax,3
        je LEVEL3
        call exitGame




    jmp gameLoop2














            gameLoop3:
         INVOKE PlaySound, OFFSET file1, NULL, 1


        mov eax,white (black * 16)
        call SetTextColor

        ; draw score:
        mov dl,0
        mov dh,0
        call Gotoxy
        mov edx,OFFSET strScore
        call WriteString
        mov eax,red
        call SetTextColor

        inc score
        mov al,score
        call WriteInt
        mov dh,0
        mov dl,50
        call Gotoxy
        mov eax,white
        call SetTextColor
        mov edx,OFFSET yourName
        call WriteString
        mov eax,red
        call SetTextColor
        mov edx,OFFSET playerName
        call writestring
        
        mov dl ,98
        mov dh,0
        call Gotoxy
        mov eax,white
        call SetTextColor
        mov edx,OFFSET livesScore
        call WriteString
        mov eax,red
        call SetTextColor
        mov al,lives
        call writeInt

        onGround3:

        ; get user key input:
        call ReadChar
        mov inputChar,al

        ; exit game if user types 'x':
        cmp inputChar,"x"
        je exitGame

        cmp inputChar,"w"
        je moveUp3

        cmp inputChar,"s"
        je moveDown3

        cmp inputChar,"a"
        je moveLeft3

        cmp inputChar,"d"
        je moveRight3
        
        cmp inputChar,27
        je pausemenu3

        cmp inputChar ,"l"
        je levelMenu3

 
        moveUp3:
                mov bl,yGhostPos1
            cmp yPos,bl
            je checkghost32
            JMP skipno32
            checkghost32:
            mov bl,xGhostPos1
            cmp xPos,bl
            jne skipno32
            dec lives 
            cmp lives,0
            je exitgame

            skipno32:
            cmp yPos,2
            je skip59
            cmp yPos,21
            je internalwall5019
            cmp yPos,16
            je internalwall5029
            cmp yPos,25
            je internalwall5039
            cmp yPos,15
            je internalwall5049
            cmp yPos,19
            je internalwall5059
            cmp yPos,27
            je internalwall5069
            cmp yPos,22
            je internalwall5079
            cmp yPos,22
            je internalwall5089
            cmp yPos,20
            je internalwall5099
            cmp yPos,10
            je internalwall5109
            cmp yPos,17
            je internalwalls5119
            cmp yPos,25
            je internalwalls5129
         
            

            JMP skip5009
            internalwall5019:
            cmp xPos,10
            je skip59
            JMP skip5009
            internalwall5029:
            cmp xPos,20
            je skip59
            JMP skip5009
            internalwall5039:
            cmp xPos,30
            je skip5
            JMP skip5009

            internalwall5049:
            cmp xPos,40
            je skip59
            JMP skip5009

            internalwall5059:
            cmp xPos,50
            je skip59
            JMP skip5009
            internalwall5069:
            cmp xPos,70
            je skip59
            JMP skip5009
            internalwall5079:
            cmp xPos,80
            je skip59
            JMP skip5009
            internalwall5089:
            cmp xPos,90
            je skip59
            JMP skip5009
            internalwall5099:
            cmp xPos,100
            je skip59
            JMP skip5009
            internalwall5109:
            mov ecx,19
            mov al,11
            l5109:
            cmp xPos,al
            je skip59
            inc al
            loop l5109
            JMP skip5009
            internalwalls5119:
            mov ecx,19
            mov al,31
            l5119:
            cmp xPos,al
            je skip59
            inc al
            loop l5119
            JMP skip5009

            

            internalwalls5129:
            mov ecx,19
            mov al,71
            l5129:
            cmp xPos,al
            je skip59
            inc al
            loop l5129
            JMP skip5009

            internalwalls5139:
            mov ecx,19
            mov al,101
            l5139:
            cmp xPos,al
            je skip59
            inc al
            loop l5139
            JMP skip5009

            
            skip5009:
            call UpdatePlayer
            dec yPos
            inc score
            skip59:
            cmp yEnemy,2
            je skip5169
            cmp yEnemy1,2
            je skip5169
            call UpdateEnemy
            call UpdateEnemy1

            
             dec yEnemy
             dec yEnemy1

             
             call DrawEnemy
             call DrawEnemy1

             call DrawPlayer
             JMP gameloop3
            skip5169:
            call UpdateEnemy
            call UpdateEnemy1
             call DrawPlayer
              call DrawEnemy
              call DrawEnemy1
               jmp gameLoop3


           

        jmp gameLoop3



        moveDown3:
                    mov bl,yGhostPos1
            cmp yPos,bl
            je checkghost1221
            JMP skipno121
            checkghost1221:
            mov bl,xGhostPos1
            cmp xPos,bl
            jne skipno121
            dec lives 
            cmp lives,0
            je exitgame

            skipno121:
        cmp yPos,28
        je skip69
            cmp yPos,5
            je internalwall6019
            cmp yPos,9
            je internalwall6029
            cmp yPos,8
            je internalwall6039
            cmp yPos,7
            je internalwall6049
            cmp yPos,3
            je internalwall6059
            cmp yPos,11
            je internalwall6069
            cmp yPos,14
            je internalwall6079
            cmp yPos,12
            je internalwall6089
            cmp yPos,13
            je internalwall609
            cmp yPos,4
            je internalwall6109
            
            JMP skip6009
            
            internalwall6019:
            cmp xPos,10
            je skip69
            JMP skip6009
            internalwall6029:
            cmp xPos,20
            je skip69
            JMP skip6009
            internalwall6039:
            cmp xPos,30
            je skip69
            JMP skip6009

            internalwall6049:
            cmp xPos,40
            je skip69
            JMP skip6009

            internalwall6059:
            cmp xPos,50
            je skip69
            JMP skip6009
            internalwall6069:
            cmp xPos,70
            je skip69
            JMP skip6009
            internalwall6079:
            cmp xPos,80
            je skip69
            JMP skip6009
            internalwall6089:
            cmp xPos,90
            je skip69
            JMP skip6009
            internalwall6099:
            cmp xPos,100
            je skip69
            JMP skip6009
            internalwall6109:
            cmp xPos,110
            je skip69
            JMP skip6009

            skip6009:
        call UpdatePlayer
        call UpdateEnemy
        call UpdateEnemy1

        inc yPos 
        inc score
        skip69:
        cmp yEnemy,28
        je skip6219
        cmp yEnemy2,28
        je skip6219
        cmp yEnemy1,28
        je skip6219
        call UpdateEnemy
        call UpdateEnemy1

        inc yEnemy
        inc yEnemy1
        inc yEnemy2
        call DrawPlayer
        call DrawEnemy
        call DrawEnemy1

        JMP gameloop3
        skip6219:
        call DrawPlayer
        call DrawEnemy
        call DrawEnemy1

        jmp gameLoop3

        moveLeft3:

                    mov bl,xGhostPos1
            cmp xPos,bl
            je checkghost12390
            JMP skipno12390
            checkghost12390:
            mov bl,yGhostPos1
            cmp yPos,bl
            jne skipno12390
            dec lives 
            cmp lives,0
            je exitgame

            skipno12390:
        cmp xPos,1
        je skip79
        cmp xPos,11
        je internalwalls7019
        cmp xPos,31
        je internalwalls7029
        cmp xPos,51
        je internalwalls7039
        cmp xPos,71
        je internalwalls7049
        cmp xPos,91
        je internalwalls7059
        cmp xPos,111
        je internalwalls7069
        cmp xPos,21
        je internalwalls7079
        cmp xPos,41
        je internalwalls7089
        cmp xPos,101
        je internalwalls7099
        cmp xPos,81
        je internalwalls7109

        
        JMP skip7009

        internalwalls7019:
        mov ecx,15
        mov al,6
        l7009:
        cmp yPos,al
        je skip79
        inc al
        Loop l7009
        JMP skip7009
        internalwalls7029:
        mov ecx,15
        mov al,10
        l7019:
        cmp yPos,al
        je skip79
        inc al
        Loop l7019
        JMP skip7009
        internalwalls7039:
        mov ecx,15
        mov al,4
        l7029:
        cmp yPos,al
        je skip79
        inc al
        Loop l7029
        JMP skip7009
        internalwalls7049:
        mov ecx,15
        mov al,12
        l7039:
        cmp yPos,al
        je skip79
        inc al
        Loop l7039
        JMP skip7009
        internalwalls7059:
        mov ecx,16
        mov al,13
        l7049:
        cmp yPos,al
        je skip79
        inc al
        Loop l7049
        JMP skip7009
        internalwalls7069:
        mov ecx,15
        mov al,5
        l7059:
        cmp yPos,al
        je skip79
        inc al
        Loop l7059
        JMP skip7009
        internalwalls7079:
        mov ecx,6
        mov al,10
        l7069:
        cmp yPos,al
        je skip79
        inc al
        Loop l7069
        JMP skip7009
        internalwalls7089:
        mov ecx,5
        mov al,10
        l7079:
        cmp yPos,al
        je skip79
        inc al
        Loop l7079
        JMP skip7009
        internalwalls7099:
        mov ecx,7
        mov al,15
        l7089:
        cmp yPos,al
        je skip79
        inc al
        Loop l7089
        JMP skip7009
        internalwalls7109:
        mov ecx,7
        mov al,15
        l7099:
        cmp yPos,al
        je skip79
        inc al
        Loop l7099

        skip7009:
        call UpdatePlayer
        call UpdateEnemy
        call UpdateEnemy1

        dec xPos
        inc score
        skip79:
        cmp xEnemy,1
        je skip7129
        cmp xEnemy1,1
        je skip7129
        cmp xEnemy2,1
        je skip7129
        call UpdateEnemy
        call UpdateEnemy1

        dec xEnemy
        dec xEnemy1

        
        call DrawPlayer
        
        skip7129:
        call UpdateEnemy
        call UpdateEnemy1

        call DrawPlayer
        call DrawEnemy
        call DrawEnemy1

         
        jmp gameLoop3



        moveRight3:
            mov bl,xGhostPos1
            cmp xPos,bl
            je checkghost123491
            JMP skipno123491
            checkghost123491:
            mov bl,yGhostPos1
            cmp yPos,bl
            jne skipno1234
            dec lives 
            cmp lives,0
            je exitgame

            skipno123491:
        cmp xPos,118
        je skip89
        cmp xPos,9
        je internalwalls8019
        cmp xPos,29
        je internalwalls8029
        cmp xPos,49
        je internalwalls8039
        cmp xPos,69
        je internalwalls8049
        cmp xPos,89
        je internalwalls8059
        cmp xPos,109
        je internalwalls8069
        cmp xPos,19
        je internalwalls8079
        cmp xPos,39
        je internalwalls8089
        cmp xPos,99
        je internalwalls8099
        cmp xPos,79
        je internalwalls8109
        JMP skip8009
        internalwalls8019:
        mov ecx,15
        mov al,6
        l8009:
        cmp yPos,al
        je skip89
        inc al
        Loop l8009
        JMP skip8009
        internalwalls8029:
        mov ecx,15
        mov al,10
        l8019:
        cmp yPos,al
        je skip89
        inc al
        Loop l8019
        JMP skip8009
        internalwalls8039:
        mov ecx,15
        mov al,4
        l8029:
        cmp yPos,al
        je skip89
        inc al
        Loop l8029
        JMP skip8009
        internalwalls8049:
        mov ecx,15
        mov al,12
        l8039:
        cmp yPos,al
        je skip89
        inc al
        Loop l8039
        JMP skip8009
        internalwalls8059:
        mov ecx,16
        mov al,13
        l8049:
        cmp yPos,al
        je skip89
        inc al
        Loop l8049
        JMP skip8009
        internalwalls8069:
        mov ecx,15
        mov al,5
        l8059:
        cmp yPos,al
        je skip89
        inc al
        Loop l8059
        JMP skip8009
        internalwalls8079:
        mov ecx,6
        mov al,10
        l8069:
        cmp yPos,al
        je skip89
        inc al
        Loop l8069
        JMP skip8009
        internalwalls8089:
        mov ecx,5
        mov al,10
        l8079:
        cmp yPos,al
        je skip89
        inc al
        Loop l8079
        JMP skip8009
        internalwalls8099:
        mov ecx,7
        mov al,15
        l8089:
        cmp yPos,al
        je skip89
        inc al
        Loop l8089
        JMP skip8009
        internalwalls8109:
        mov ecx,7
        mov al,15
        l8099:
        cmp yPos,al
        je skip89
        inc al
        Loop l8099
        JMP skip8009


        skip8009:
        
        call UpdatePlayer
        call UpdateEnemy
        call UpdateEnemy1

        inc xPos
        inc score
        skip89:
        call UpdateEnemy
        call UpdateEnemy1

        cmp xEnemy,118
        je skip80119
         cmp xEnemy1,118
        je skip80119
         cmp xEnemy2,118
        je skip80119
        inc xEnemy
        inc xEnemy1


        call DrawPlayer
        call DrawEnemy
        call DrawEnemy1

        JMP gameloop
        skip80119:
        call DrawPlayer
        call DrawEnemy
        call DrawEnemy1

        jmp gameLoop

        pausemenu3:
        call clrscr
        call DisplaypauseScreen
        JMP pauseret3

        levelMenu3:
        call clrscr
        call DisplayLevelScreen
        call ReadInt
        cmp eax,1
        je LEVEl1
        cmp eax,2
        je LEVEL2
        cmp eax,3
        je LEVEL3
        call exitGame




    jmp gameLoop3






    exitGame:
    


    call clrscr
    mov dh,5
    mov dl,5
    call Gotoxy
    mov edx,OFFSET endGameMessage
    call WriteString
    mov dh,10
    mov dl,50
    call Gotoxy
    mov edx,OFFSET nameMessage
    call writeString
    mov edx,OFFSET playerName
    call WriteString
    mov edx,OFFSET emptyline
    call WriteString
    mov dh,11
    mov dl,50
    call Gotoxy
    mov edx,OFFSET scoreMessage
    call WriteString
    mov edx,OFFSET score
    call WriteInt
    mov edx,OFFSET emptyline
    call WriteString
    INVOKE PlaySound, OFFSET file3, NULL, 1
    call waitmsg
    
    exit
main ENDP







Displayground PROC

  mov dh,2
   mov dl,1
    mov ecx,29
    coinsloop:
    
    call DrawCoin
    inc dh
    loop coinsloop

    mov eax,blue ;(black * 16)
    call SetTextColor
    mov dl,0
    mov dh,29
    call Gotoxy
    mov edx,OFFSET ground
    call WriteString
    mov dl,0
    mov dh,1
    call Gotoxy
    mov edx,OFFSET ground
    call WriteString

 mov ecx,27
    mov dh,2
    mov temp,dh
    l1:
    mov dh,temp
    mov dl,0
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop l1


    mov ecx,27
    mov dh,2
    mov temp,dh
    l2:
    mov dh,temp
    mov dl,119
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop l2
    call DrawPlayer
    call DrawEnemy
ret 
Displayground ENDP
DisplayPacmanScreen PROC
    mov eax, cyan ; set text color to white
    call SetTextColor

    mov dl, 5 ; set x position
    mov dh, 5 ; set y position
    call Gotoxy

    mov edx, OFFSET pacmanMessage ; load the message
    call WriteString

    ; Wait for any key press
    ;call ReadChar
    call waitMsg
    ; Clear the screen
    call Clrscr
   

    ret
DisplayPacmanScreen ENDP
DisplayLevelScreen PROC
 INVOKE PlaySound, OFFSET file2, NULL, 1
  mov eax, Yellow ; set text color to white
    call SetTextColor

    mov dl, 5 ; set x position
    mov dh, 5 ; set y position
    call Gotoxy
    mov edx, OFFSET levelMessage
    call WriteString
    ret

DisplayLevelScreen ENDP
DisplaypauseScreen PROC
 INVOKE PlaySound, OFFSET file2, NULL, 1
    mov eax, Yellow ; set text color to white
    call SetTextColor

    mov dl, 5 ; set x position
    mov dh, 5 ; set y position
    call Gotoxy

    mov edx, OFFSET pasueMessage ; load the message
    call WriteString

    ; Wait for any key press
    call ReadInt
    cmp eax,2
    je skip

    cmp eax,1
    je skip2
    ;call waitMsg
    ; Clear the screen
    call Clrscr
   skip:
   exit
   skip2:
   call clrscr
    ret
DisplaypauseScreen ENDP
DisplayMenuScreen PROC
againmenu:

     INVOKE PlaySound, OFFSET file2, NULL, 1
    mov eax, cyan ; set text color to white
    call SetTextColor

    mov dl, 5; set x position
    mov dh, 2 ; set y position
    call Gotoxy

    mov edx, OFFSET menuMessage ; load the message
    call WriteString
  
    
   ; Wait for any key press
    call ReadInt
    cmp eax,3
    je exitGame  ; Jump to exitGame label if eax is equal to 3
    
    cmp eax,2
    je inst



    jmp skip1
   exitGame:
   call clrscr
    exit
        inst:
        INVOKE PlaySound, OFFSET file2, NULL, 1
    call clrscr
     mov eax, Yellow ; set text color to white
    call SetTextColor

    mov dl, 5 ; set x position
    mov dh, 5 ; set y position
    call Gotoxy

    mov edx, OFFSET instmesssage ; load the message
    call WriteString

    call waitMsg
    call Clrscr
    JMP againmenu
    skip1:
    call clrscr
    ret
DisplayMenuScreen ENDP

DrawPlayer PROC
    ; draw player at (xPos,yPos):
    mov eax,yellow ;(blue*16)
    call SetTextColor
    mov dl,xPos
    mov dh,yPos
    call Gotoxy
    mov al,"X"
    call WriteChar
    ret
DrawPlayer ENDP

UpdatePlayer PROC
comment @
cmp yPos,2
je skip
cmp yPos,28
je skip
cmp xPos,1
je skip
cmp xPos,118
je skip
@
    mov dl,xPos
    mov dh,yPos
    call Gotoxy
    mov al," "
    call WriteChar
    skip:
    ret
UpdatePlayer ENDP

DrawCoin PROC
    mov eax,green
     call SetTextColor
    ;mov dl,1
   ; mov dh,2
    call Gotoxy
    mov edx,OFFSET coin
    call WriteString
    ret
DrawCoin ENDP

CreateRandomCoin PROC
    mov eax,100
    inc eax
    call RandomRange
    mov xCoinPos,al
    mov eax,28
    mov yCoinPos,al
    ret
CreateRandomCoin ENDP



DrawEnemy PROC
    ; draw player at (xPos,yPos):
    mov eax,Red ;(blue*16)
    call SetTextColor
    mov dl,xEnemy
    mov dh,yEnemy
    call Gotoxy
    mov al,"@"
    call WriteChar
    ret
DrawEnemy ENDP

UpdateEnemy PROC

    mov eax,green
    call SetTextColor
    mov dl,xEnemy
    mov dh,yEnemy
    call Gotoxy
    mov al,"."
    call WriteChar
    skip:
    ret
UpdateEnemy ENDP

DrawEnemy1 PROC
    ; draw player at (xPos,yPos):
    mov eax,cyan ;(blue*16)
    call SetTextColor
    mov dl,xEnemy1
    mov dh,yEnemy1
    call Gotoxy
    mov al,"&"
    call WriteChar
    ret
DrawEnemy1 ENDP

UpdateEnemy1 PROC

    mov eax,green
    call SetTextColor
    mov dl,xEnemy1
    mov dh,yEnemy1
    call Gotoxy
    mov al,"."
    call WriteChar
    skip:
    ret
UpdateEnemy1 ENDP


createwalls PROC

mov eax, red
call SetTextColor
;walls
    mov ecx,15
    mov dh,6
    mov temp,dh
    l3:
    mov dh,temp
    mov dl,10
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop l3

    mov ecx,15
    mov dh,10
    mov temp,dh
    l4:
    mov dh,temp
    mov dl,30
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop l4

      mov ecx,6
    mov dh,10
    mov temp,dh
    l14:
    mov dh,temp
    mov dl,20
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop l14

      mov ecx,5
    mov dh,10
    mov temp,dh
    l15:
    mov dh,temp
    mov dl,40
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop l15

      mov ecx,15
    mov dh,4
    mov temp,dh
    l5:
    mov dh,temp
    mov dl,50
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop l5


     mov ecx,15
    mov dh,12
    mov temp,dh
    l6:
    mov dh,temp
    mov dl,70
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop l6

     mov ecx,14
    mov dh,13
    mov temp,dh
    l7:
    mov dh,temp
    mov dl,90
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop l7

      mov ecx,7
    mov dh,15
    mov temp,dh
    l17:
    mov dh,temp
    mov dl,80
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop l17

      mov ecx,5
    mov dh,15
    mov temp,dh
    l18:
    mov dh,temp
    mov dl,100
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop l18


    mov ecx,15
    mov dh,5
    mov temp,dh
    l8:
    mov dh,temp
    mov dl,110
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop l8
    ; draw ground at (0,29):
 
 mov dh,9
 mov dl,11
 call Gotoxy
 mov edx,OFFSET stwall
 call WriteString
    
 mov dh,18
 mov dl,31
 call Gotoxy
 mov edx,OFFSET stwall
 call WriteString

  mov dh,26
 mov dl,71
 call Gotoxy
 mov edx,OFFSET stwall
 call WriteString

  mov dh,12
 mov dl,91
 call Gotoxy
 mov edx,OFFSET stwall
 call WriteString

;walls end
ret
createwalls ENDP

createwalls2 PROC

mov eax, red
call SetTextColor
;walls
    mov ecx,15
    mov dh,8
    mov temp,dh
    l3:
    mov dh,temp
    mov dl,10
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop l3

        mov ecx,15
    mov dh,10
    mov temp,dh
    l10:
    mov dh,temp
    mov dl,20
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop l10

    mov ecx,19
    mov dh,10
    mov temp,dh
    l4:
    mov dh,temp
    mov dl,30
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop l4

      mov ecx,15
    mov dh,4
    mov temp,dh
    l5:
    mov dh,temp
    mov dl,50
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop l5

        mov ecx,7
    mov dh,15
    mov temp,dh
    l17:
    mov dh,temp
    mov dl,80
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop l17

     mov ecx,15
    mov dh,10
    mov temp,dh
    l11:
    mov dh,temp
    mov dl,60
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop l11


     mov ecx,15
    mov dh,12
    mov temp,dh
    l6:
    mov dh,temp
    mov dl,70
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop l6

     mov ecx,16
    mov dh,13
    mov temp,dh
    l7:
    mov dh,temp
    mov dl,90
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop l7

    mov ecx,15
    mov dh,5
    mov temp,dh
    l8:
    mov dh,temp
    mov dl,110
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop l8
    ; draw ground at (0,29):
 
 mov dh,9
 mov dl,11
 call Gotoxy
 mov edx,OFFSET stwall
 call WriteString
    
 mov dh,18
 mov dl,31
 call Gotoxy
 mov edx,OFFSET stwall
 call WriteString
  
  mov dh,9
 mov dl,61
 call Gotoxy
 mov edx,OFFSET stwall
 call WriteString

  mov dh,26
 mov dl,71
 call Gotoxy
 mov edx,OFFSET stwall
 call WriteString

  mov dh,12
 mov dl,91
 call Gotoxy
 mov edx,OFFSET stwall
 call WriteString

;walls end
ret
createwalls2 ENDP

createwalls3 PROC

mov eax, red
call SetTextColor
;walls
    mov ecx,15
    mov dh,5
    mov temp,dh
    l3:
    mov dh,temp
    mov dl,10
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop l3

    mov ecx,18
    mov dh,10
    mov temp,dh
    l4:
    mov dh,temp
    mov dl,30
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop l4

      mov ecx,7
    mov dh,10
    mov temp,dh
    l14:
    mov dh,temp
    mov dl,40
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop l14

      mov ecx,20
    mov dh,4
    mov temp,dh
    l5:
    mov dh,temp
    mov dl,50
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop l5

         mov ecx,10
    mov dh,4
    mov temp,dh
    l13:
    mov dh,temp
    mov dl,60
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop l13


     mov ecx,15
    mov dh,12
    mov temp,dh
    l6:
    mov dh,temp
    mov dl,70
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop l6

     mov ecx,16
    mov dh,13
    mov temp,dh
    l7:
    mov dh,temp
    mov dl,90
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop l7

    mov ecx,15
    mov dh,5
    mov temp,dh
    l8:
    mov dh,temp
    mov dl,110
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop l8
    ; draw ground at (0,29):
 
 mov dh,9
 mov dl,11
 call Gotoxy
 mov edx,OFFSET stwall
 call WriteString
    
 mov dh,18
 mov dl,31
 call Gotoxy
 mov edx,OFFSET stwall
 call WriteString

  mov dh,24
 mov dl,42
 call Gotoxy
 mov edx,OFFSET stwall
 call WriteString

   mov dh,4
 mov dl,51
 call Gotoxy
 mov edx,OFFSET stwall
 call WriteString

  mov dh,23
 mov dl,71
 call Gotoxy
 mov edx,OFFSET stwall
 call WriteString

  mov dh,15
 mov dl,91
 call Gotoxy
 mov edx,OFFSET stwall
 call WriteString

  mov dh,4
 mov dl,91
 call Gotoxy
 mov edx,OFFSET stwall
 call WriteString

   mov dh,8
 mov dl,91
 call Gotoxy
 mov edx,OFFSET stwall
 call WriteString


;walls end
ret
createwalls3 ENDP






DrawGhost PROC
    ; draw player at (xPos,yPos):
    mov eax,cyan ;(blue*16)
    call SetTextColor
    mov dl,xGhostPos1
    mov dh,yGhostPos1
    call Gotoxy
    mov al,"&"
    call WriteChar
    ret
DrawGhost ENDP

UpdateGhost PROC
    mov eax,green
    call settextcolor

    mov dl,xGhostPos1
    mov dh,yGhostPos1
    call Gotoxy
    mov al,"."
    call WriteChar

   
    cmp ghostDirection1, 1 ; Right
    je moveGhostRight1
    cmp ghostDirection1, 2 ; Down
    je moveGhostDown1
    cmp ghostDirection1, 3 ; Left
    je moveGhostLeft1
    cmp ghostDirection1, 4 ; Up
    je moveGhostUp1
    ret

moveGhostRight1:
    inc xGhostPos1
    
    cmp xGhostPos1, 116 
    jge changeGhostDirectionTODown1

    ret

moveGhostDown1:
    inc yGhostPos1

    cmp yGhostPos1, 27 
    jge changeGhostDirectionToLeft1
    ret


moveGhostLeft1:
    dec xGhostPos1
   
    cmp xGhostPos1, 3 
    jl changeGhostDirectionToUp1
    ret


moveGhostUp1:
    dec yGhostPos1
 
    cmp yGhostPos1, 3 
    jl changeGhostDirectionToRight1
    ret

changeGhostDirectionToDown1:
    
    mov ghostDirection1, 2
    ret

changeGhostDirectionToLeft1:
    
    mov ghostDirection1, 3
    ret

    changeGhostDirectionToUp1:
    
    mov ghostDirection1, 4
    ret

changeGhostDirectionToRight1:
	mov ghostDirection1, 1
	ret

UpdateGhost ENDP



END main

