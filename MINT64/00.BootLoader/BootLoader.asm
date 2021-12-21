[ORG 0x00]
[BITS 16]

SECTION .text

mov ax, 0xB800                      ; AX 레지스터에 0xB800 복사 -> 0xB8000
mov ds, ax                          ; DS 세그먼트 레지스터에 AX 값(0xB800) 복사

mov byte [ 0x00 ], 'M'              ; DS세그먼트:오프셋 0xB800:0x0000 에 'M' 복사
mov byte [ 0x01 ], 0x4A             ; DS세그먼트:오프셋 0xB800:0x0001 에 0x4A 복사 

jmp $                               ; 현재 위치에서 무한루프 수행 

times 510 - ( $ - $$ )  db  0x00    ; 현재 위치부터 510 까지 0x00 으로 채우기
db 0x55                             ; 1byte 선언, 0x55 (부트섹터 표기)
db 0xAA                             ; 1byte 선언, 0xAA (부트섹터 표기)
