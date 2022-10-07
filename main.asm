
     list p=16f628a
     #include "p16f628a.inc"             ; Include register definition file
      
      org h'0000'
SAYAC1	EQU	H'20'		;SAYAC1 saklayıcısının adresi
SAYAC2	EQU	H'21'		;SAYAC2 saklayıcısının adresi
	BANKSEL 	TRISB		;BANK1'e geç
	CLRF		TRISB		;PortB'nin tüm uçları çıkış
	MOVLW	d'11111111'		;W ? h'FF'   h''FF tüm sayılar 1 demek
	MOVWF	TRISA		;PortA'nın tüm uçları giriş
	BANKSEL 	PORTB		;BANK0'a geç
	MOVLW	d'00000111'		;W saklayıcıya b’00000111’ yükle
	MOVWF	CMCON 		;PORTA girişleri dijital I/O
	CLRF		PORTB		;PortB'yi sıfırla
BASLA	
	MOVLW	d'00001010'	;W ? d’10’ H'0A'
	MOVWF	SAYAC1		;SAYAC1 ? W
TEST
	BTFSC	PORTA,0		;PortA'nın 0. bit'i 0 mı?
	GOTO		TEST			;Hayır, tekrar test et
	MOVLW	d'00100000'	;Evet, W ? d'32'  H'20'	
	MOVWF	SAYAC2		;SAYAC2 ? W	
GECIKME					;Gecikme sağlama bölümü
	NOP					; Bir komut çevrimi bekle
	NOP					;		"
	NOP					;		"
	NOP		
	NOP	
	DECFSZ	SAYAC2, F		;SAYAC2=SAYAC2-1, SAYAC2=0 mı?
	GOTO		GECIKME		;Hayır, tekrar gecikme yap
AZALT					;Evet, SAYAC1’i “1” azalt
	DECFSZ	SAYAC1, F		;SAYAC1=SAYAC1-1,SAYAC1=0 mı?
	GOTO	YAK				;Hayır, sayıyı PortB’de göster
	GOTO	BASLA			;Evet, tekrar 9’dan başla
YAK
	MOVF		SAYAC1,W		;W ? SAYAC1
	MOVWF	PORTB		;SAYAC1'i PortB'ye gönder.
	GOTO		TEST			;PortA'yi tekrar test et.
	END					;Program kodlarının sonu