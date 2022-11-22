[ORG 0x00]                          ; 코드의 시작 주소를 0x00 으로 설정
[BITS 16]                           ; 이하의 코드는 16비트 코드로 설정

SECTION .text                       ; .text 섹션(세그먼트)을 정의

jmp 0x07c0:START                    ; CS 세그먼트 레지스터에 0x07C0 을 복사하면서 START 레이블로 이동

START:
    mov ax, 0x07c0                  ; 부트로더의 시작 주소(0x7C00)를 세그먼트 레지스터 값으로 변환
    mov ds, ax                      ; DS 세그먼트 레지스터에 설정
    mov ax, 0xB800                  ; 비디오 메모리의 시작 주소(0xB8000)를 세그먼트 레지스터 값으로 변환
    mov es, AX                      ; ES 세그먼트 레지스터에 설정

    mov si, 0                       ; SCREENCLEAR 에 사용될 인덱스 레지스터 초기화

.SCREENCLEARLOOP:
    mov byte [ es: si ], 0          ; 비디오 메모리의 기존 문자에 0 으로 초기화
    mov byte [ es: si + 1], 0x07    ; 비디오 메모리의 속성 문자에 0x07(검은바탕 하얀글자) 로 초기화
    add si, 2                       ; 인덱스 + 2 

    cmp si, 80 * 25 * 2             ; 현재 인덱스가 화면전체 크기까지 도달하지 못했다면, 처음으로 
    jl .SCREENCLEARLOOP

    mov si, 0                       ; MESSAGE1 에 사용될 인덱스 레지스터 초기화
    mov di, 0                       ; 비디오 메모리에 사용될 인덱스 레지스터 초기화

.MESSAGELOOP:
    mov cl, byte [ MESSAGE1 + si ]  ; cl 레지스터에 MESSAGE1 한바이트 복사

    cmp cl, 0                       ; 복사한 문자가 0 이라면(문자열 끝), .MESSAGEEND 로 이동
    je .MESSAGEEND

    mov byte [ es: di ], cl         ; 비디오 메모리에 문자 하나 복사
    add si, 1                       ; 문자열 인덱스 증가
    add di, 2                       ; 비디오 메모리 인덱스 증가(+2)
    jmp .MESSAGELOOP                ; 처음으로

.MESSAGEEND:
    jmp $                           ; 현재 위치에서 무한루프 수행 

MESSAGE1:   db 'APPLE17 OS Boot Loader Start !!', 0

times 510 - ( $ - $$ )  db  0x00    ; 현재 위치부터 510 까지 0x00 으로 채우기
db 0x55                             ; 1byte 선언, 0x55 (부트섹터 표기)
db 0xAA                             ; 1byte 선언, 0xAA (부트섹터 표기)
