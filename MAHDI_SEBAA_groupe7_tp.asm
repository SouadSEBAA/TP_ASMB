
; ----------------------------------- Segment de donnees----------------------------------------- 

sdonnee SEGMENT     
    
;-------------- Segment de donnee associe a l'affichage de l'introduction-------------------------------
                                                                                                               



affiche        db 10,13, "*************************************************************** "
               db 10,13, "*                                                             * "
               db 10,13, "*               _                                             * "
               db 10,13, "*              |_|                                            * "
               db 10,13, "*             /_/                                             * "
               db 10,13, "*     ___  ___ _    ECOLE nationale Superieure d'Informatique * "
               db 10,13, "*    / _ \/ __| |   Cycle Preparatoire integre (CPI) - SYS2   * "
               db 10,13, "*   |  __/\__ \ |                                             * "
               db 10,13, "*    \___||___/_|                                             * "
               db 10,13, "*                                                             * "
               db 10,13, "* Ralise par: - MAHDI ZHOR YASMINE - SEBAA SOUAD   -          * "
               db 10,13, "* Section: B - Groupe: 7 (VII ) - 2018/2019                   * "
               db 10,13, "* Encadre par: Mr.KHELOUAT                                    * "
               db 10,13, "*                                                             * "
               db 10,13, "*************************************************************** ",10,13,10,13
               db  "              APPUYER SUR UNE TOUCHE POUR COMMENCER                       ",10,13,10,13 ,'$'
        
intro db 10,13," ******************************************************************************"
      db 10,13," *                                                                            *"
      db 10,13," *                TP ASSEMBLEUR - Convertisseur ARABE <===> ROMAIN            *"
      db 10,13," *                                                                            *" 
      db 10,13," ******************************************************************************"                                                  
            DB     " 	    ²²²²²²²²²²²²²²²        ²²²²²²²²²²      |-----|  ",13,10
            DB     " 		²²²²²²²²²²²²²²²       ²²²²²²²²²²²²     |-----|  ",13,10
            DB     "         ²²²²                 ²²²²       ²²²    \_____\ ",13,10
            DB     "         ²²²²                 ²²²         ²²    ²²²²²²  ",13,10
            DB     " 		²²²²                  ²²²              ²²²²²²   ",13,10
            DB     " 		²²²²²²²²²²²²²²²        ²²²²²²²²²²      ²²²²²²   ",13,10
            DB     " 		²²²²²²²²²²²²²²²         ²²²²²²²²²²     ²²²²²²   ",13,10
            DB     " 		²²²²                           ²²²²    ²²²²²²   ",13,10
            DB     " 		²²²²                 ²²         ²²²    ²²²²²²   ",13,10
            DB     " 		²²²²                 ²²²²      ²²²²    ²²²²²²   ",13,10
            DB     " 		²²²²²²²²²²²²²²²       ²²²²²²²²²²²²     ²²²²²²   ",13,10
            DB     " 		²²²²²²²²²²²²²²²        ²²²²²²²²²²      ²²²²²²  ",13,10,'$'
                                         
                                       
                                       
                                                                                                                                          
        
        
;----------------------- Segment de donnee associe a l'affichage du menu ------------------------      
        
      
menu  db 10,13,10,13," Veuillez ENTRER VOTRE CHOIX   " 
      db 10,13," "
      db 10,13,"  1) Conversion ARABE -> ROMAIN " 
      db 10,13,"  2) Conversion ROMAIN -> ARABE "
      db 10,13,"  3) Quitter " 
      db 10,13,'$'
      
      
choix:  db 10,13,"     ENTRER ICI VOITRE CHOIX :  $"   
err_choix db 10,13,"/!\ ERREUR - Le choix doit etre compris entre 1 et 3 .",10,13,'$'   
                                                     
               
                
;------------------ Segment de donnee associe a la conversion arabe --> romain -------------------
  
 entree  DB 8 DUP(?)  
decimal DW ? 
romaine DW "M","D","C","L","X","V","I" 
arabe  DW  1000h,500h,100h,50h,10h,5h,1h

msg_err DB 13,10,'/!\ ERREUR ! le nombre entre doit etre inferieur ou egal a 3999.',13,10,'Veuillez entrer un autre nombre  :  ','$'

msg_err0 DB 13,10,'/!\ ERREUR ! le nombre "0" n''a pas d''equivalent .',13,10,'Veuillez entrer un autre nombre  :  ','$'

msg2  DB 13,10,'la conversion en chiffres romain donne :  ','$' 
            
 msg1  DB 13,10,'Veuillez entrer un nombre inferieur ou egal a 3999 (les 4 positions seulement):',13,10,13,10,'     ->  $' 


chaine DW 15 dup(?),'$'
J      DW 13,10  ?
cpT3    DW 13,10   ?
SAUV   DW 13,10   ?
SAUV2   DW 13,10  ?  

;------------------ Segment de donnee associe a la conversion romain --> arabe -------------------

romain2 dw 'I','V','X','L','C','D','M'
arabe2 dw 1,5,10,50,100,500,1000
err db 0ah,0dh,"Revisez votre syntaxe"    
msg_entree db 10,13,'Veuillez entrer le nombre romain en majuscule :$'
msg_resultat db 0dh,0ah,'Voici son equivalent en arabe :$'
nombre db 20 dup('$') ;la chaine pour mettre le nombre romain a convertir
a dw 10
 
  
sdonnee ENDS 
;---------------------------------------- Segment de code ---------------------------------------------


scode SEGMENT 
    
ASSUME DS:sdonnee,CS:scode 


;------------------------------------ INTRODUCTION ----------------------------------------------- 
    
Introd PROC
      
      MOV DX,offset affiche
      MOV AH,9
      INT 21H

      MOV AH,8
      INT 21H

      MOV DX,offset intro
      MOV AH,9
      INT 21H

_menu:   

      MOV DX,offset menu
      MOV AH,9
      INT 21H 

_choix:      
         
      MOV DX,offset choix
      MOV AH,9
      INT 21H        
        
         
      MOV AH,1
      INT 21H
      
      CMP AL,33h  ;on compare avec le code ascci du nombre 3 pour aller a la 3ieme choix du menu
      JE quit
                   ;on compare avec le code ascii du nombre 1 pour aller a la premiere choix du menu
      CMP AL,31h
      JE arb_rom
      
      call rom_arb
      jmp _menu

      MOV DX,offset err_choix  ;affiche erreur si le choix n''existe pas dans le menu
      MOV AH,9
      INT 21H 

      JMP _choix 

      RET 
      
Introd ENDP 

;------------------------------------------------------------------------------------------------ 

;---------------------- Lecture d'un des chiffres du nombre arabe (sur un octet) -------------------------------------
                                      

CHIF  PROC
    
      MOV AH,1  
      INT 21H  
      
      
      CMP	 AL, 30h  ; comparer le chiffre entre avec 0, s'il est inferieur alors il est invalide   
      JL INVALID
      CMP	 AL, 39h  ; comparer le chiffre entre avec 9, s'il est superieur alors il est invalide
      JG	 INVALID
     
      SUB AL,30h
      MOV [SI],AL
      INC SI
      MOV [SI],0
      INC SI
          
      LOOP CHIF
      
      RET
       
CHIF  ENDP      

;--------------------------------------------------------------------------------------------------    
  
  
;------------------------------- Lecture du nombre entier ---------------------------------------  
      

LECT1 PROC 
      
      MOV DX,offset msg1
      MOV AH,9
      INT 21H
             
      
DEB:  LEA SI,entree
      
      MOV CX,4   ; le nombre arabe se compose de 4 chiffres au plus 
             
      CALL CHIF  ; lecture du chiffre
      
      ;On recupere dans BX le nombre sur 4 chiffres
            
      MOV AX,0
      LEA SI,entree
      ADD SI,6
      
      MOV BX,[SI] 
      
      OR AX,BX 
      SUB SI,2
      MOV BX,[SI]
      SHL BX,4
     
      OR AX,BX  
      
      SUB SI,2
      MOV BX,[SI]
      SHL BX,8
     
      OR AX,BX 
      
      SUB SI,2
      MOV BX,[SI]
      SAL BX,12
     
      OR AX,BX
      
      MOV BX,AX 
                   
      ;Comparaison du nombre avec 3000
      
      CMP BX,3999h
      JA INVALID 
      
      ;comparaison du nombre avec 0000
      
      CMP BX,0000h
      JE invalid0   
      
      Jmp CONV   ; faire la conversion Arabe --> romain
       
      
INVALID:      
      MOV DX,offset msg_err
      MOV AH,9
      INT 21H
      
      JMP DEB 
      
      RET  
LECT1 ENDP      
      
invalid0: 

      MOV DX,offset msg_err0
      MOV AH,9
      INT 21H
      
      JMP DEB 
      
      RET
      
            

;------------------------------------------------------------------------------------------------      


;------------------------- Conversion du nombre en chiffres s -----------------------------

arb_rom PROC 
    
     
    
    
        
    
    CALL LECT1  ;Lecture du nombre     
      
CONV:
    MOV DX,offset msg2
    MOV AH,9
    INT 21H  
      
    MOV decimal,BX    
    
    
    MOV DI,0
    
    LEA SI,chaine
    
    
    
bcl3:      Cmp [SI],'$' 
           JNE efface1 
           JMP SUITE
efface1:   MOV [SI],0
           INC SI
           JMP bcl3  
           
           
           
           
SUITE: Mov SI,0            
       MOV DI,0 
       
               
                
BOUCLE: 
       CMP DI,14         
       JE FINBOUCLE
       MOV BX,decimal
       CMP BX ,arabe[DI]
       JL Incrementation
       MOV cpt3, 0 
      
       
       
TQ: 


   
       MOV BX,decimal
       CMP BX,arabe[DI] 
       JL  FTQ
       SUB BX,arabe[DI]
       INC cpt3
       MOV decimal,BX 
       JMP TQ   
       
       
       
FTQ:   MOV AX,cpt3
       MUL arabe[DI] 
       MOV SAUV ,AX
       cmp cpt3,4
       JE SINON
       MOV CX, cpt3
       
       
       
                              
           
                              
BOUCLE1:   
           MOV AX,romaine[DI]
           MOV chaine[SI] , AX 
           ADD  SI,2 
LOOP BOUCLE1 

jmp incrementation
       
   
   
SINON:  ; Les cas particuliers 
        SUB SI,2 
; il existe des nombre qui ne se trouvent pas dans le tableau on vas les traiter        
            
CAS1:
        CMP SAUV,4
        JNE cas2
        MOV AX , chaine[si]
        cmp ax , romaine[10]
        JNE IV
        mov  ax,chaine[si]
        mov  ax,romaine[12]
        mov  chaine[si],ax
        add si ,2
        mov  ax,chaine[si]
        mov  ax,romaine[8]
        mov  chaine[si],ax
        add si ,2
        jmp boucle
        
IV:
        add si ,2
        mov  ax,chaine[si]
        mov  ax,romaine[12]
        mov  chaine[si],ax 
        add si ,2
        mov  ax,chaine[si]
        mov  ax,romaine[10]
        mov  chaine[si],ax
        add si ,2
        jmp boucle
     
CAS2:
        CMP SAUV,40h
        JNE CAS3
        MOV AX , chaine[si]
        cmp ax , romaine[6]
        JNE XL
        mov  ax,chaine[si]
        mov  ax,romaine[8]
        mov  chaine[si],ax
        add si ,2
        mov  ax,chaine[si]
        mov  ax,romaine[4]
        mov  chaine[si],ax
        add si ,2
        jmp boucle 
        
        
XL:     add si ,2 
        mov  ax,chaine[si]
        mov  ax,romaine[8]
        mov  chaine[si],ax 
        add si ,2
        mov  ax,chaine[si]
        mov  ax,romaine[6]
        mov  chaine[si],ax 
        add si ,2
        jmp boucle
CAS3:    
        
        
        MOV AX , chaine[si]
        cmp ax , romaine[2]
        JNE CD
        mov  ax,chaine[si]
        mov  ax,romaine[4]
        mov  chaine[si],ax
        add si ,2
        mov  ax,chaine[si]
        mov  ax,romaine[0]
        mov  chaine[si],ax
        add si ,2
        jmp boucle 
CD:
        add si ,2 
        mov  ax,chaine[si]
        mov  ax,romaine[4]
        mov  chaine[si],ax 
        add si ,2
        mov  ax,chaine[si]
        mov  ax,romaine[2]
        mov  chaine[si],ax 
        add si ,2
        jmp boucle
                       
incrementation:   ADD DI,2 
                  JMP BOUCLE
   
    
FINBOUCLE: 

         ;Affichage de la chaine
    
         
        LEA DX,chaine
        MOV AH,9
        INT 21H
        
        
    
        
    JMP _menu
    
    RET
     
arb_rom ENDP
 
;------------------------------------------------------------------------------------------------     
;------------------------- Verification de la justesse du nombre romain entree -----------------------------



verifier PROC
          pusha
          mov dx,0
suiv:                
          mov ax,[bp]
          cmp ax,'$'
          jz fin_vrf
          inc dh
          add bp,2
          cmp ax,1000
          jz do1     ;si chiffre != M alors sa frequence<4
freq:     cmp dh,3
          ja erreur  ;si freq>3 , c'est faux
do1:      
          cmp [bp],'$'
          jz fin_vrf
          cmp ax,[bp]
          ja do2
          jz suiv
          mov dh,00h
          jmp suiv
do2:
          mov bx,[bp]
          add bp,2
          cmp bx,[bp]
          jz erreur  ; si le chiffre qu'on va soustraire se repete deux fois de suite, c'est faux (ex: MIIX)
          jmp diff
          ;on calcul la division entre deux chiffres 
diff:          
          xor dx,dx
          div bx
          cmp ax,10  ;si  =10 ou =5 alors c'est correct 
          jz suiv    
          cmp ax,5   
          jz suiv
          jmp erreur
                                  
fin_vrf:  popa
          ret          
verifier ENDP
           
;------------------------------------------------------------------------------------------------     
;------------------------- Procedure d'affichage -----------------------------
           
afficher PROC
          mov ah,09
          int 21h
          ret 
afficher endp                    
          
;------------------------------------------------------------------------------------------------     
;------------------------- Procedure de lecture -----------------------------
          
lecture PROC
          mov ah,0ah
          int 21h
          ret
lecture endp

;------------------------------------------------------------------------------------------------     
;------------------------- Conversion du nombre romain -----------------------------
rom_arb PROC                   
                   
          ;lire le nombre romain
          lea dx,msg_entree
          call afficher
          mov nombre,20 
          lea dx,nombre
          call lecture
                        
                        
          ;Initialisation
          mov si,2   ;indice de chaine du nombre en romain
          mov di,0   ;indice du tableau romain
          mov ax,'$'
          push ax    ;pour marquer la fin du nombre dans la pile, une fois qu'on depile
          mov cx,0
          mov al,nombre[si]
          mov ah,0
            
          ;empiler chaque equivalent arabe de chaque lettre dans la pile de gauche a droite pour ca:
          ;apres cette operation le sommet pointera vers l'equivalent de la derniere lettre la plus a gauche
          ;1-Identifier chaque lettre du nombre a celles du tableau
reconnai:    
          cmp ax,romain2[di]  
          jz convert
          add di,2
          cmp di,14
          jz erreur
          jmp reconnai
          
           
          ;2-Convertir chaque lettre en son equivalent arabe
convert:  mov ax,arabe2[di] 
          push ax           ;empiler le resultat
          inc cx            ;passer a la prochaine lettre
          inc si
          mov al,nombre[si]
          mov ah,0  
          mov di,0          ;indice du tableau de conversion
          cmp al,0Dh        ;si la fin des lettres du nombre romain, on calcul (0Dh signifie la fin de la chaine)
          jnz reconnai
          
          ;verifier si la syntaxe du nombre est juste
          mov ax,0
          mov bp,sp         ;sauvegarder le sommet de pile dans bp qui point vers la valeur de la derniere lettre du nombre
          call verifier     
          mov sp,bp         ;affecter au sp sa valeur avant d'appeler la procedure
          
          ;calcul du nombre en arabe pour ca:
          ;on va comparer chaque chiffre au sommet de pile avec celui d'avant
comp:     pop bx
          mov bp,sp
          cmp [bp],'$'
          jz calcul
          cmp bx,[bp]
          ja faire    ;si c'est superieur on soustrait
          
calcul:   add ax,bx   ;sinon on additionne
          loop comp
          jmp fin_convert
                  
faire:    pop dx      ;on depile le chiffre soustrait
          sub bx,dx   ;soustraction
          dec cx
          jmp calcul
          
          ;extraire les chiffrs composant le nombre en arabe, par des divisions sur 10                 
          ;convertir chaque chiffre en ascii        
fin_convert:      
          mov di,6           ;initialiser l'indice de chaine a la case du dernier caractere de la chaine
          mov nombre[di],'$' ;marquer la fin de la chaine pour l'affichage
          dec di
ecriture: xor dx,dx
          div a              ;div 10
          add dl,30h         ;le chiffre a afficher est dans dx, donc on lui ajoute 30h pour obtenir son code ascii
          mov nombre[di],dl  ;on le met dans la chaine a afficher plutard
          dec di
          cmp ax,0000h       ;tant que le nombre div 10 != 0, on continue a extraire ses chiffres
          jnz ecriture
          
          ;afficher le resultat
          lea dx,msg_resultat
          call afficher
          lea dx,nombre[di+1]
          call afficher
          jmp the_end
          
          ;en cas d'erreur
erreur:  
          lea dx,err
          call afficher
          
the_end:  jmp _menu
          ret
             
rom_arb endp

;------------------------------------------------------------------------------------------------            


;----------------------------------- PROGRAMME PRINCIPAL ----------------------------------------

DEBUT: 
          
      MOV AX, sdonnee
      MOV DS, AX     
                     
      CALL Introd 
             
quit: MOV AH,4ch
      INT 21h   
       
scode ENDS
      END DEBUT
                       
;------------------------------------------------------------------------------------------------                       
                       

