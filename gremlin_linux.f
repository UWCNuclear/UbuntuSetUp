c	J.Iwanicki, July 2005
c	this is a version to be compiled with 
c	Linux g77 - GNU project Fortran 77 compiler
c	modifications to the previous version:
c	- trigonometric functions working on angles in degrees are defined within
c	  the code
c	- "unit 5" - the standard input/output seems to be unknown to the g77 
c	  compiler, so it's use was removed from the code

	PROGRAM GREMLIN
C   Gamma-Ray Efficiency Measurement and Line INtensity calculation
C   Must be linked with [KAVKA.SILVIA]POLFIT

2     write(*,1)
1	FORMAT(/' GREMLIN menu:      0   Stop'/
     2       '                    1   Fit efficiency calibration'/
     3       '                    2   Calculate intensities'/
     1       /'$Choose option: ')
	read(*,*)IOPTION
	IF(IOPTION.EQ.0) THEN
	   write(*,*)' '
	   STOP 'Good-bye.'
	ELSE IF(IOPTION.EQ.1) THEN
	   CALL GREMLIN_ATT(0)
	   CALL GREMLIN_FIT
	ELSE IF(IOPTION.EQ.2) THEN
	   CALL GREMLIN_CALC
	END IF
	GOTO 2
	END
c*****************************
c*****************************
	Block data
	PARAMETER (NABSORBERS=9,NENERGIES=20,MATS=30)
	REAL*4 MU_L,MU_U,LOGE(NENERGIES),
     1 LOGMU_L(NABSORBERS,NENERGIES),LOGMU_U(NABSORBERS,NENERGIES)
	REAL*8 ZZ_L,ZZ_U
	CHARACTER OUT*50
C   MATS = max. number of points defining spline curve
C   (actually, MATS = NENERGIES would be enough)
	COMMON /LOGTRANS/ E0,MU0,EFF0,OUT
	COMMON /SPL/
     1 X_SPL(MATS),Y_SPL(NABSORBERS,MATS),N_SPL,D_SPL(MATS),
     1 ZZ_L(NABSORBERS,MATS),ZZ_U(NABSORBERS,MATS),
     1 THICKN(NABSORBERS),MU_L(NABSORBERS,NENERGIES),
     1 MU_U(NABSORBERS,NENERGIES),E(NENERGIES),EDGE(NABSORBERS)
	DATA E0/50./,MU0/1/
C   NOTE:  If E0 is changed, the "DATA EDGE" statement must be changed.
C   _L and _U refers to lower and upper mu(E) curve, respectively.
C   These curves are used below and above the K edge EDGE(j), respectively.
	DATA EDGE
     1 /-100.,-100.,-100.,-100.,-100.,-100.,0.2988594,0.5653593,0./
C   EDGE(j) = log(EK/E0) for Ta and Pb, where EK = K-edge (67.416 and 88.004
C   keV, respectively).
	DATA E                          /  30.,      40.,      50.,
     1    60.,      67.416,   80.,      88.004,  100.,     150.,
     2   200.,     300.,     400.,     500.,     600.,     800.,
     3  1000.,    1500.,    2000.,    3000.,    4000. /
	DATA (MU_U(1,K),K=1,NENERGIES)  /   2.9950,   1.5186,   0.9883,
     1     0.7472,   0.6465,   0.5442,   0.5028,   0.4592,   0.3718,
     2     0.3302,   0.2814,   0.2501,   0.2278,   0.2103,   0.1844,
     3     0.1657,   0.1350,   0.1163,   0.0958,   0.0838 /
	DATA (MU_U(2,K),K=1,NENERGIES)  /   0.5719,   0.4659,   0.4196,
     1     0.3948,   0.3810,   0.3621,   0.3521,   0.3396,   0.3035,
     2     0.2764,   0.2403,   0.2143,   0.1952,   0.1805,   0.1591,
     3     0.1433,   0.1162,   0.0997,   0.0800,   0.0686 /
	DATA (MU_U(3,K),K=1,NENERGIES)  /  63.6474,  28.2594,  15.1905,
     1     9.4198,   7.0211,   4.6590,   3.7646,   2.8938,   1.5275,
     2     1.1372,   0.8656,   0.7375,   0.6602,   0.6042,   0.5262,
     3     0.4710,   0.3836,   0.3344,   0.2843,   0.2605 /
	DATA (MU_U(4,K),K=1,NENERGIES)  /  96.8077,  43.2238,  23.1829,
     1    14.1815,  10.4404,   6.7765,   5.3974,   4.0591,   1.9701,
     2     1.3842,   0.9936,   0.8398,   0.7473,   0.6819,   0.5902,
     3     0.5273,   0.4297,   0.3762,   0.3218,   0.2972 /
	DATA (MU_U(5,K),K=1,NENERGIES)  / 327.1891, 153.3988,  84.3462,
     1    51.4419,  37.6415,  23.8208,  18.4152,  13.0690,   4.7734,
     2     2.6045,   1.3393,   0.9686,   0.7925,   0.6905,   0.5747,
     3     0.5005,   0.4032,   0.3564,   0.3184,   0.3073 /
	DATA (MU_U(6,K),K=1,NENERGIES)  / 296.6041, 140.7300,  77.1983,
     1    47.6487,  34.8244,  21.9036,  16.9699,  12.1153,   4.3955,
     2     2.3529,   1.1857,   0.8348,   0.6759,   0.5873,   0.4839,
     3     0.4211,   0.3365,   0.2981,   0.2667,   0.2586 /
	DATA (MU_U(7,K),K=1,NENERGIES)  / 820.3520, 578.9185, 383.6803,
     1   256.5229, 193.9125, 125.9603,  98.4680,  70.7145,  25.3025,
     2    12.5408,   5.1931,   3.0882,   2.2154,   1.7679,   1.3148,
     3     1.0773,   0.8176,   0.7237,   0.6685,   0.6629 /
	DATA (MU_U(8,K),K=1,NENERGIES)  / 810.4764, 491.3156, 313.9358,
     1   211.0472, 161.7832, 108.0200,  85.7718,  62.6794,  22.8285,
     2    11.2823,   4.5195,   2.5995,   1.8045,   1.3987,   0.9930,
     3     0.7983,   0.5872,   0.5146,   0.4717,   0.4717 /
	DATA (MU_U(9,K),K=1,NENERGIES)  /   3.2923,   1.6087,   1.0142,
     1     0.7444,   0.6326,   0.5196,   0.4739,   0.4261,   0.3362,
     2     0.2968,   0.2518,   0.2238,   0.2038,   0.1883,   0.1644,
     3     0.1479,   0.1204,   0.1044,   0.0854,   0.0754 /
	DATA (MU_L(1,K),K=1,NENERGIES)  /NENERGIES*1./
	DATA (MU_L(2,K),K=1,NENERGIES)  /NENERGIES*1./
	DATA (MU_L(3,K),K=1,NENERGIES)  /NENERGIES*1./
	DATA (MU_L(4,K),K=1,NENERGIES)  /NENERGIES*1./
	DATA (MU_L(5,K),K=1,NENERGIES)  /NENERGIES*1./
	DATA (MU_L(6,K),K=1,NENERGIES)  /NENERGIES*1./
	DATA (MU_L(7,K),K=1,NENERGIES)  / 359.0972, 169.0519,  93.3653,
     1    58.5605,  43.6441,  28.1670,  21.8873,  15.3752,   4.1655,
     2     1.2764,   0.1430,   1.887E-2, 2.835E-3, 4.755E-4, 1.754E-5,
     3     8.671E-7, 1.195E-9, 4.215E-12,3.179E-16,1.150E-19 /
	DATA (MU_L(8,K),K=1,NENERGIES)  / 339.7885, 160.9872,  89.4007,
     1    56.0816,  41.5629,  26.8862,  21.2780,  15.8234,   7.7195,
     2     6.3499,   9.2218,  21.6889,  63.2674, 204.4561,2390.412,
     3 28332.16,     1.0472E7, 2.3836E9, 3.4947E13,1.4282E17 /
	DATA (MU_L(9,K),K=1,NENERGIES)  /NENERGIES*1./
C   Attenuation coefficients calculated from E. Storm, H.I. Israel,
C   Nuclear Data Tables A7 (1970) 565
	end

C******************************************************************************
C******************************************************************************

	SUBROUTINE GREMLIN_ATT(ITHICK)
C   ITH=0 means 
	PARAMETER (NABSORBERS=9,NENERGIES=20,MATS=30)
	REAL*4 MU_L,MU_U,LOGE(NENERGIES),
     1 LOGMU_L(NABSORBERS,NENERGIES),LOGMU_U(NABSORBERS,NENERGIES)
	REAL*8 ZZ_L,ZZ_U
	CHARACTER MATERIAL(NABSORBERS)*10,OUT*50
C   MATS = max. number of points defining spline curve
C   (actually, MATS = NENERGIES would be enough)
	COMMON /LOGTRANS/ E0,MU0,EFF0,OUT
	COMMON /SPL/
     1 X_SPL(MATS),Y_SPL(NABSORBERS,MATS),N_SPL,D_SPL(MATS),
     1 ZZ_L(NABSORBERS,MATS),ZZ_U(NABSORBERS,MATS),
     1 THICKN(NABSORBERS),MU_L(NABSORBERS,NENERGIES),
     1 MU_U(NABSORBERS,NENERGIES),E(NENERGIES),EDGE(NABSORBERS)
C   _L and _U refers to lower and upper mu(E) curve, respectively.
C   These curves are used below and above the K edge EDGE(j), respectively.
	DATA MATERIAL/'aluminum','carbon','iron','copper',
     1 'cadmium','tin','tantalum','lead','silicon'/

C--- Absorber thicknesses

	IF(ITHICK.EQ.0) THEN
	write(*,3)
3	FORMAT(/' Please enter absorber thicknesses in cm.'/
     1 ' (Enter a negative value if no absorber was used.)'/)
	DO J=1,NABSORBERS
	   write(*,4)MATERIAL(J)
4	   FORMAT('$         ',A10)
	   read(*,*)THICKN(J)
	   IF(THICKN(J).LT.0.) THEN
	      DO 5 JJ=1,NABSORBERS
5	      THICKN(JJ)=0.
	      GOTO 55
	   END IF
	END DO
	END IF

C--- Journal file

55    write(*,10)
10	FORMAT(/
     1' An optional journal file will be created, containing the form'
     2/' of the fitted function, initial and fitted parameters, etc.'
     3//'$Journal file name, or <RETURN> for no file: ')
	read(*,11)OUT
11	FORMAT(A50)
	IF(OUT.NE.' ') THEN
	   OPEN(3,file=OUT,status='NEW')
	   WRITE(3,12)
12	   FORMAT(//
     1  ' *************************************************************'
     2 /
     1  ' **  Gamma-ray detector efficiency fit  (GREMLIN option 1)  **'
     2 /
     1  ' *************************************************************'
     1  ///' FORM OF FITTED FUNCTION, LOG(EFF) AS FUNCTION OF LOG(E):'//
     1  '    ATTENUATION TERM:  ABSORBER    THICKNESS (cm)'/)
	   DO 13 J=1,NABSORBERS
13	   WRITE(3,14) MATERIAL(J),THICKN(J)
14	   FORMAT(23X,A10,F16.3)
	END IF

C--- Transform energies and mu's to logarithmic variables

	DO 6 K=1,NENERGIES
	LOGE(K)=LOG(E(K)/E0)
	DO 6 J=1,NABSORBERS
	LOGMU_L(J,K)=LOG(MU_L(J,K)/MU0)
6	LOGMU_U(J,K)=LOG(MU_U(J,K)/MU0)

C--- Determine upper and lower cubic spline function for every absorber
C    For Ta and Pb, the "lower" and "upper" curves represent the attenuation
C    coefficient below and above the K edge, respectively.
C    For other absorbers, the "upper" curve represents the attenuation coeff.
C    and the "lower" curve is unused.

	N_SPL=NENERGIES
	DO J=1,NABSORBERS
	   IF(THICKN(J).NE.0.) THEN
	      DO 9 K=1,N_SPL
	      X_SPL(K)=LOGE(K)
9	      Y_SPL(J,K)=LOGMU_L(J,K)
	      CALL SPLINE(J,'L')
	      DO 99 K=1,N_SPL
	      X_SPL(K)=LOGE(K)
99	      Y_SPL(J,K)=LOGMU_U(J,K)
	      CALL SPLINE(J,'U')
	   END IF
	END DO

C   For every absorber #J, an interpolated mu [cm-1] at energy EKEV [keV] can
C   now be calculated - example for upper curve:
C             mu  =  MU0 * EXP(SPLCURVE(J,'U',LOG(EKEV/E0)))

	RETURN
	END

C******************************************************************************
C******************************************************************************

	SUBROUTINE GREMLIN_FIT         ! August 1st, 1986
	PARAMETER (MATP=500,NEU=21,NTA=25,MATS=30,MAXPOINTS=8192,ELO=250.)
	PARAMETER (NABSORBERS=9,NENERGIES=20,MAXSOU=9)
	COMMON /SPL/
     1 X_SPL(MATS),Y_SPL(NABSORBERS,MATS),N_SPL,D_SPL(MATS),
     1 ZZ_L(NABSORBERS,MATS),ZZ_U(NABSORBERS,MATS),
     1 THICKN(NABSORBERS),MU_L(NABSORBERS,NENERGIES),
     1 MU_U(NABSORBERS,NENERGIES),E_ATT(NENERGIES),EDGE(NABSORBERS)
	REAL*4 MU_L,MU_U
	COMMON /LOGTRANS/ E0,MU0,EFF0,OUT
	COMMON /MATRIX/ NP_P,N_P,DET,IBIGDET,X_P(MATP),Y_P(MATP),
     1 DY_P(MATP),P_P(MATS),A_P(MATS,MATS),B_P(MATS)
	REAL*8 X_P,Y_P,DY_P,P_P,A_P,B_P,ZZ_L,ZZ_U  ! _P denotes POLFIT variables
	CHARACTER FILNAM*40,ANS*1,OUT*50,upcase
	DIMENSION E(MATP),EFF(MATP),DEFF(MATP)
	COMMON /FUNF/ PAR(MATS),DERIV(MATS),NP_GEFFIC,LOCKED(MATS),
     1 X(MAXPOINTS),Y(MAXPOINTS),DY(MAXPOINTS),
     1 NP,IPOW,IDEG,PW,WS,IPW,IWS,IFIRST(MAXSOU+1),FNORM(MAXSOU),NSOU
C   /FUNF/ is used for communication with subroutine GREMLIN_GEFFIC
	logical LOCKED,PW,WS

C--- Gamma energies and relative efficiencies with errors for Eu152 and Ta182
C    from R.A. Meyer: "Multigamma-ray calibration sources", LLL 1978

	REAL EEU(NEU),IEU(NEU),DIEU(NEU),ETA(NTA),ITA(NTA),DITA(NTA)
	DATA EEU/ 121.783, 244.692, 295.939, 344.276, 367.789, 411.115,
     1         443.967, 488.661, 564.021, 586.294, 688.678, 778.903,
     1         867.388, 964.131,1005.279,1085.914,1112.116,1212.950,
     1        1299.124,1408.011,1528.115/
	DATA IEU/1362.,    359.,     21.1,  1275.,     40.5,   107.,
     1         148.,     19.5,    23.6,    22.0,    40.8,   619.,
     1         199.,    692.,     31.0,   475.,    649.,     67.,
     1          78.,   1000.,     12.7/
	DATA DIEU/16.,6.,.5,9.,.8,1.,2.,.2,.5,.5,.8,8.,4.,9.,.7,7.,
     1 9.,.8,1.,3.,.3/
	DATA ETA/  31.737,  65.722,  67.750,  84.680, 100.106, 113.673,
     1         116.421, 152.430, 156.390, 179.397, 198.350, 222.108,
     1         229.322, 264.078, 927.983,1001.696,1113.414,1121.299,
     1        1157.505,1189.051,1221.406,1231.019,1257.421,1273.735,
     1        1289.158/
	DATA ITA/  27.5,    87.5,  1310.,     71.9,   404.,     53.4,
     1          12.6,   199.5,    75.9,    88.2,    41.9,   216.,
     1         103.9,   102.6,    17.3,    58.7,    13.2,  1000.,
     1          29.2,   471.,    778.,    331.,     43.6,    19.5,
     1          42.9/
	DATA DITA/.6,.17,100.,1.4,5.,.5,.2,1.8,1.,1.,.9,3.,1.8,1.8,.3,.6,
     1 .3,3.,.3,8.,13.,5.,.8,.3,.8/

C--- Which source?

	NP=0         ! Total number of calibration points
	NSOU=0          ! Number of "sources", i.e. independently normalized
C                       ! sets of calibration points
23	IF(NSOU+1.GT.MAXSOU) THEN
	   write(*,47)MAXSOU
47	   FORMAT(/I3,' data sets is the limit!')
	   GOTO 45
	END IF
	write(*,2)NSOU+1
2	FORMAT(/' Which calibration source was used for
     1 indepently normalized data set #',I2,'?'/'$Type E (Eu152),
     1 T (Ta182), O (other), or <RETURN> if finished: ')
89    read(*,4)ANS
	ANS=upcase(ANS)
4	FORMAT(A1)
	IF(ANS.EQ.' ') GOTO 45
	NSOU=NSOU+1
	IFIRST(NSOU)=NP+1       ! IFIRST(i) tells where data set #i begins

C--- Calculate efficiency (Eu152)

	IF(ANS.EQ.'E') THEN
	   write(*,20)
20	   FORMAT(/' Give name of file containing peak-area data,'/
     1 '$or hit <RETURN> to enter areas from keyboard: ')
	   read(*,6)FILNAM
6	   FORMAT(A40)
	   IF(FILNAM.EQ.' ') write(*,3)
3	   FORMAT(/' Please enter the measured peak area and error for',
     1  ' each Eu152 line.'/
     1  ' For a line that you don''t wish to include, type two zeroes.'
     1  ///' Gamma      Tabulated         Peak area & abs. error'/
     1  ' energy     intensity'/)
	   IF(FILNAM.NE.' ') OPEN(1,file=FILNAM,status='OLD',ERR=22)
c         IF(FILNAM.NE.' ') OPEN(1,file=FILNAM,status='OLD',READONLY,ERR=22)
	   DO N=1,NEU
	      IF(FILNAM.EQ.' ') THEN                       !
		   write(*,1)EEU(N),IEU(N),DIEU(N)              !
1	         FORMAT('$',F8.3,F9.1,' +-',F5.1,'     ')  !
		   read(*,*)A,DA                             ! Read area and error
	      ELSE                                         !
	         READ(1,*,ERR=24) A,DA                     !
	      END IF                                       !
	      IF(A.NE.0.) THEN
	         NP=NP+1
	         E(NP)=EEU(N)         ! Energy
	         EFF(NP)=A/IEU(N)            ! Efficiency
	         DEFF(NP)=EFF(NP)*SQRT((DA/A)**2+(DIEU(N)/IEU(N))**2)  ! Eff. error
	      END IF
	   END DO
	   IF(FILNAM.NE.' ') CLOSE(1)

C--- Calculate efficiency (Ta182)

	ELSE IF(ANS.EQ.'T') THEN
	   write(*,20)
	   read(*,6)FILNAM
	   IF(FILNAM.EQ.' ') write(*,11)
11	   FORMAT(/' Please enter the measured peak area and error for',
     1  ' each Ta182 line.'/
     1  ' For a line that you don''t wish to include, type two zeroes.'
     1  ///' Gamma      Tabulated         Peak area & abs. error'/
     1  ' energy     intensity'/)
	   IF(FILNAM.NE.' ') OPEN(1,file=FILNAM,status='OLD',ERR=22)
c         IF(FILNAM.NE.' ') OPEN(1,file=FILNAM,status='OLD',READONLY,ERR=22)
	   DO N=1,NTA
	      IF(FILNAM.EQ.' ') THEN           !
		   write(*,1)ETA(N),ITA(N),DITA(N)  !
		   read(*,*)A,DA                 ! Read area and error
	      ELSE                             !
	         READ(1,*,ERR=24) A,DA         !
	      END IF                           !
	      IF(A.NE.0.) THEN
	         NP=NP+1
	         E(NP)=ETA(N)
	         EFF(NP)=A/ITA(N)      ! Efficiency
	         DEFF(NP)=EFF(NP)*SQRT((DA/A)**2+(DITA(N)/ITA(N))**2)  ! Eff. error
	      END IF
	   END DO
	   IF(FILNAM.NE.' ') CLOSE(1)

C--- Calculate efficiency (other source)

	ELSE IF(ANS.EQ.'O') THEN
	   write(*,20)
	   read(*,6)FILNAM
	   IF(FILNAM.EQ.' ') write(*,10)MATP
10	   FORMAT(/' For each gamma line, please enter:'/
     1  15X,'1  Gamma energy in keV'/15X,'2  Relative intensity'/
     1  15X,'3  Absolute error in relative intensity'/
     1  15X,'4  Measured peak area'/15X,'5  Absolute area error'//
     1  ' Type five zeroes to stop.      Maximum is',I4,' lines.'/)
	   IF(FILNAM.NE.' ') OPEN(1,file=FILNAM,status='OLD',ERR=22)
c         IF(FILNAM.NE.' ') OPEN(1,file=FILNAM,status='OLD',READONLY,ERR=22)
19	   IF(FILNAM.EQ.' ') THEN
		write(*,9)
9	      FORMAT('$Energy; Intensity & error; Area & error: ')
		read(*,*)EOTHER,RI,DRI,A,DA
	      IF(EOTHER.EQ.0.) GOTO 23      ! End of this data set
	   ELSE
	      READ(1,*,ERR=24,END=230) EOTHER,RI,DRI,A,DA
	   END IF
	   IF(EOTHER.NE.0.) THEN
	      NP=NP+1
	      E(NP)=EOTHER
	      EFF(NP)=A/RI      ! Efficiency
	      DEFF(NP)=EFF(NP)*SQRT((DA/A)**2+(DRI/RI)**2)     ! Eff. error
	   END IF
	   GOTO 19
	ELSE
	   write(*,88)
88	   FORMAT('$',44X,'OOPS... TRY AGAIN: ')
	   NSOU=NSOU-1
	   GOTO 89
	END IF
	GOTO 23    ! Jump back for next source
230	CLOSE(1)
	GOTO 23
45	IFIRST(NSOU+1)=NP+1

C--- Show efficiency and total attenuations at all calibration energies E(N)

	write(*,176)
176	FORMAT(/' Calculated efficiencies and total transmissions
     1 through absorbers:'//
     1'   energy        relative       efficiency     relative'/
     1'   (keV)         efficiency     error          transmission'/)
	ISOU=1
	NN=0
	DO 120 N=1,NP
	   NN=NN+1
	   IF(N.EQ.IFIRST(ISOU)) THEN
		write(*,*)
     1   '------------------------------------------------------------'
	      ISOU=ISOU+1
	   END IF
	   IF(NN.EQ.18) THEN
		write(*,44)
44	      FORMAT('$Type <RETURN> for more: ')
		read(*,4)ANS
		ANS=upcase(ANS)
	      NN=0
	   END IF
120   write(*,*)E(N),EFF(N),DEFF(N),EXP(-ATT(LOG(E(N)/E0)))

C--- Choose fitted function

	write(*,87)
87	FORMAT(/'$Type <RETURN> to continue: ')
	read(*,4)ANS
	ANS=upcase(ANS)
	write(*,86)
86	FORMAT(//
     1' GREMLIN will fit  log(EFF/EFF0)  as function of  log(E/E0).'
     1/' The function is a sum of up to 4 terms, #3 and 4
     1 being optional:'/
     1'         1:  a polynomial of degree 1, 2, or 3'/
     1'         2:  the attenuation term  -mu * x'/
     1'         3:  a "Woods-Saxon" term   - log(1+exp[(c-E)/d])'/
     1'         4:  a  1/log(E/E0)**N  term (positive N)')
	EFF0=0.           !
	DO 55 N=1,NP      ! Average efficiency to be used for
55	EFF0=EFF0+EFF(N)  ! logarithmic transformation
	EFF0=EFF0/NP      !
	write(*,*)' '
	write(*,*)'E0 =',E0,' keV,   EFF0 =',EFF0

C - - - Polynomial term

27    write(*,25)
25	FORMAT(/'$Choose the polynomial degree: ')
	read(*,*)IDEG
	IF(IDEG.LT.1.OR.IDEG.GT.3) GOTO 27

C - - - Woods-Saxon term

	write(*,128)
128	FORMAT(/'$Wish to include the Woods-Saxon term?  Y/N: ')
	read(*,4)ANS
	ANS=upcase(ANS)
	WS=ANS.eq.'Y'

C - - - 1/x**N term

	write(*,126)
126	FORMAT(/'$Wish to include the  1/log(E/E0)**N  term?  Y/N: ')
	read(*,4)ANS
	ANS=upcase(ANS)
	PW=ANS.EQ.'Y'
	IF(PW) THEN
127      write(*,26)
26	   FORMAT('$Choose the power N: ')
	   read(*,*)IPOW
	   IF(IPOW.LE.0) GOTO 127
	END IF

C--- Write functional form in journal file

	IF(OUT.NE.' ') THEN
	   WRITE(3,862) IDEG
862	   FORMAT(/'    POLYNOMIAL DEGREE',I2)
	   IF(WS) THEN
	      WRITE(3,*) '   "WOODS-SAXON" TERM INCLUDED'
	   ELSE
	      WRITE(3,*) '   "WOODS-SAXON" TERM NOT INCLUDED'
	   END IF
	   IF(PW) THEN
	      WRITE(3,863) IPOW
863	      FORMAT('    LOW-ENERGY POWER TERM:  N =',I2)
	   ELSE
	      WRITE(3,*) '   LOW-ENERGY POWER TERM NOT INCLUDED'
	   END IF
	END IF

C--- Preliminary linear fit above energy ELO for each data set separately

	IF(NSOU.NE.1) THEN
	   N_P=2
	   DO ISOU=1,NSOU
		write(*,49)ELO,ISOU
49	      FORMAT(/' Preliminary linear fit above',F8.2,
     1     ' keV for data set #',I2)
	      LAST=IFIRST(ISOU+1)-1
	      NP_P=0
	      DO N=IFIRST(ISOU),LAST
	         IF(E(N).GT.ELO) THEN
	            NP_P=NP_P+1
	            X_P(NP_P)=LOG(E(N)/E0)      !
	            Y_P(NP_P)=LOG(EFF(N)/EFF0)  ! Transformation to log. variables
	            DY_P(NP_P)=DEFF(N)/EFF(N)   !
	         END IF
	      END DO
	      IF(NP_P.LT.2) THEN
	         N=LAST-1
		   write(*,190)ELO,E(N)
190	         FORMAT(' There are not enough points above',F8.2,' keV.'
     1        /' Therefore, the',F8.2,'-keV point is also used.')
	         X_P(2)=LOG(E(N)/E0)
	         Y_P(2)=LOG(EFF(N)/EFF0)
	         DY_P(2)=DEFF(N)/EFF(N)
	         IF(NP_P.EQ.0) THEN
	            N=LAST-2
			write(*,191)E(N)
191	            FORMAT(' And the',F8.2,'-keV point is used as well.')
	            X_P(1)=LOG(E(N)/E0)
	            Y_P(1)=LOG(EFF(N)/EFF0)
	            DY_P(1)=DEFF(N)/EFF(N)
	         END IF
	         NP_P=2
		   write(*,87)
		   read(*,4)ANS
		   ANS=upcase(ANS)
	      END IF
	      CALL POLFIT(*17,*17,*17)

C--- Initial normalization of all data sets to data set #1

	      IF(ISOU.EQ.1) THEN
	         COEFF=P_P(1)     ! 0th-order polynomial coefficient
	      ELSE
	         FNORM(ISOU)=COEFF-P_P(1)     ! FNORM = log(epsnew/epsold)
	         EXPFNORM=EXP(FNORM(ISOU))
		   write(*,*)'Normalization factor',EXPFNORM
	         DO 48 N=IFIRST(ISOU),IFIRST(ISOU+1)-1
	         EFF(N)=EXPFNORM*EFF(N)
48	         DEFF(N)=EXPFNORM*DEFF(N)
	      END IF 
	   END DO
	END IF

C--- Preliminary polynomial fit above energy ELO for all the data
C    Purpose: to get good initial values for polynomial coefficients

	N_P=IDEG+1
	NP_P=0
	DO N=1,NP
	   IF(E(N).GT.ELO) THEN
	      NP_P=NP_P+1
	      X_P(NP_P)=LOG(E(N)/E0)      !
	      Y_P(NP_P)=LOG(EFF(N)/EFF0)  ! Transformation to log. variables
	      DY_P(NP_P)=DEFF(N)/EFF(N)   !
	   END IF
	END DO
	CALL POLFIT(*17,*17,*17)

C--- Show results of preliminary fit

	write(*,185)IDEG,ELO
185	FORMAT(/' First we make a preliminary fit of a polynomial',
     1' of degree',I2/' in the region above',F5.0,' keV.'/' The fitted
     1 coefficients (a0 = constant term, etc.) will then be'/
     1' used as initial values for the full fit.'//' Result:'/)
	DO 228 I=1,N_P
228   write(*,18)I-1,SNGL(P_P(I))
18	FORMAT('         a',I1,' =',E14.7)
	write(*,*)' '
	write(*,*)'Correlation matrix:'
	DO 34 I=1,N_P
34    write(*,*)(SNGL(A_P(I,J)),J=1,N_P)

C--- Fit of full function

	DO 29 N=1,NP
	X(N)=LOG(E(N)/E0)
	Y(N)=LOG(EFF(N)/EFF0)
29	DY(N)=DEFF(N)/EFF(N)
	CALL GREMLIN_GEFFIC

C--- Store fitted function on disk

	write(*,100)
100	FORMAT(/' NOTE: To be able to calculate intensities,
     1 you must store the calibration'/' in a file, even if you go
     1 to Option 2 without leaving GREMLIN.'//
     1 '$Calibration storage file name (or <RETURN> for no file: ')
	read(*,6)FILNAM
	IF(FILNAM.NE.' ') THEN
	   OPEN(1,file=FILNAM,status='NEW')
	   WRITE(1,*) THICKN
	   WRITE(1,*) IPOW,IDEG,IPW,IWS,EFF0,NP_GEFFIC
	   WRITE(1,*) (PAR(I),I=1,NP_GEFFIC)
	   WRITE(1,*) WS,PW
	   DO 101 I=1,NP_GEFFIC
101	   WRITE(1,*) (A_P(I,J),J=1,NP_GEFFIC)
	   CLOSE(1)
	END IF
	RETURN

C--- Error messages

22    write(*,*)'FILE NOT FOUND',CHAR(7)
	NSOU=NSOU-1
	GOTO 23
24    write(*,*)'READ ERROR',CHAR(7)
	NSOU=NSOU-1
	GOTO 23
17    write(*,*)'PRELIMINARY POLYNOMIAL FIT FAILED.
     1 CHECK YOUR DATA AND TRY AGAIN.',CHAR(7)
	RETURN
	END

C******************************************************************************
C******************************************************************************

	SUBROUTINE GREMLIN_GEFFIC        ! = GEFFIC.FOR adapted for GREMLIN
	IMPLICIT DOUBLE PRECISION (Z)
	PARAMETER (MATP=500,MATS=30,NPLOTPOINTS=300,MAXSOU=9)
	PARAMETER (MAXPOINTS=8192)        ! Max. no. of data points
	PARAMETER (THRESHMIN=10.,THRESHMAX=300.,SKINMIN=5.,SKINMAX=100.)
	COMMON /LOGTRANS/ E0,MU0,EFF0,OUT
	COMMON /MATRIX/ NPOINTS,NPARAM,DETER,IBIGDET,ZXDATA(MATP),
     1 ZYDATA(MATP),ZDY(MATP),ZPARAM(MATS),ZA(MATS,MATS),ZB(MATS)
	COMMON /FUNF/ PAR(MATS),DERIV(MATS),NP,LOCKED(MATS),
     1 X(MAXPOINTS),Y(MAXPOINTS),DY(MAXPOINTS),
     1 MCH2,IPOW,IDEG,PW,WS,IPW,IWS,IFIRST(MAXSOU+1),FNORM(MAXSOU),NSOU
	DIMENSION PAROLD(MATS),PARBEST(MATS),ABEST(MATS,MATS),
     1 Y0(MAXPOINTS)
	logical LOCKED,PW,WS
	CHARACTER NAME*50,OUT*50,HEADER*45,SYMBOL(MAXSOU)*1,ANS*1,upcase
c	EXTERNAL IFO

C---------- Initialize arrays

	DO 72 I=1,MATS
	LOCKED(I)=.FALSE.
	PAR(I)=0.
	DO 72 J=1,MATS
72	ABEST(I,J)=0.

C--- Initial values for polynomial coefficients

721   write(*,*)' '
	DO 700 J=1,IDEG+1
	PAR(J)=ZPARAM(J)     ! Initial values from preliminary polynomial fit
700   write(*,701)J,PAR(J)
701	FORMAT(' Initial value for parameter #',I2,' is ',E14.7)
	NP=IDEG+1
	IF(OUT.NE.' ') THEN
	   WRITE(3,550)
550	   FORMAT(//' Parameters are numbered as follows:'/)
	   DO 551 J=1,IDEG+1
551	   WRITE(3,552) J,J-1
552	   FORMAT(
     1  '    Parameter #',I2,' =',I2,'-order polynomial coefficient')
	END IF

C--- Initial values for Woods-Saxon parameters

	IF(WS) THEN
	   IWS=NP+1
	   write(*,710)IWS,IWS+1
710	   FORMAT(/' Parameters #',I1,',',I2,' =  c, d  in  exp[(c-E)/d]'/
     1  '$Please give initial values in keV: ')
	   read(*,*)PAR(IWS),PAR(IWS+1)
	   IF(PAR(IWS).LT.THRESHMIN) PAR(IWS)=THRESHMIN
	   IF(PAR(IWS).GT.THRESHMAX) PAR(IWS)=THRESHMAX
	   IF(PAR(IWS+1).LT.SKINMIN) PAR(IWS+1)=SKINMIN
	   IF(PAR(IWS+1).GT.SKINMIN) PAR(IWS+1)=SKINMAX
	   NP=NP+2
	   IF(OUT.NE.' ') THEN
	      WRITE(3,553) IWS,IWS+1
553	      FORMAT('    Parameter #',I2,' = "Woods-Saxon" threshold'/
     1     '    Parameter #',I2,' = "Woods-Saxon" skin thickness')
	   END IF
	END IF

C--- Determine initial value for last parameter by varying it within a range

	IF(PW) THEN
	   IPW=NP+1
	   write(*,732)IPW,IPOW
732	   FORMAT(/' Parameter #',I1,' = coefficient of  1/log(E) **',I2)
	   write(*,*)
     1  'An initial value for this parameter will be found by',
     1  ' scanning a range.'
	   NTRIES=0
610      write(*,799)
799	   FORMAT('$Please enter lo, hi, step: ')
	   read(*,*)PARLO,PARHI,PARSTEP
	   NTRIES=NTRIES+1
	   SUMSQMIN=1.E20
	   DO 650 VALUE=PARLO,PARHI,PARSTEP
	      PAR(IPW)=VALUE
	      SUMSQ=0.
	      DO 641 K=1,MCH2
	      IF(SUMSQ.GT.1.E20) GOTO 650    ! Interrupt summation if chisq. very high
641	      SUMSQ=SUMSQ+((FITFUN(X(K))-Y(K))/DY(K))**2
	      IF(SUMSQ.LT.SUMSQMIN) THEN
	         SUMSQMIN=SUMSQ
	         BESTVALUE=VALUE
	      END IF
650	   CONTINUE
	   IF((ABS(BESTVALUE-PARLO).LT.PARSTEP.OR.
     1  ABS(BESTVALUE-PARHI).LT.PARSTEP).AND.NTRIES.LT.5) THEN
		write(*,*)'The best value is one of the endpoints:',BESTVALUE
		write(*,*)'Try a different range.'
	      GOTO 610
	   ELSE
		write(*,*)'Selected initial value:',BESTVALUE
	      PAR(IPW)=BESTVALUE
	   END IF
	   NP=NP+1
	   IF(OUT.NE.' ') THEN
	      WRITE(3,554) IPW,IPOW
554	      FORMAT(
     1     '    Parameter #',I2,' = coefficient of  1/log(E) **',I2)
	   END IF
	END IF
C
C---------- Write initial values in journal file
C
	IF(MCH2.LT.NP) THEN
	write(*,*)'ABORTED!  REASON: FEWER DATA POINTS THAN PARAMETERS.'
	RETURN
	END IF
	write(*,709)NP
709	FORMAT(/' GEFFIC fit with',I2,' parameters.')
	IF(OUT.NE.' ') THEN
	WRITE(3,64)
64	FORMAT(///' Initial parameter values:')
	DO 62 J=1,NP
62	WRITE(3,63) J,PAR(J)
63	FORMAT(3X,'PAR(',I2,') = ',E15.5)
	END IF
C
C---------- Number of parameters to be varied (NPARAM)
C
	NPARAM=0
	DO 81 J=1,NP
81	IF(.NOT.LOCKED(J)) NPARAM=NPARAM+1
C
C---------- Sum of squares
C
	ITER=0
	SUMSQ=0.
	SUMSQMIN=0.
c      CALL lib$establish(IFO)       ! Establish overflow condition handler
C-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X BEGINNING OF ITERATION LOOP
35	SUMSQOLD=SUMSQ
	N=0
44	SUMSQ=0.
	DO 41 K=1,MCH2
41	SUMSQ=SUMSQ+((FITFUN(X(K))-Y(K))/DY(K))**2
	SUMSQ=SUMSQ/(MCH2-NPARAM)
C   MCH2-NPARAM = number of statistical degrees of freedom
C
C - - - If SUMSQ has increased, go back and reduce parameter changes
C     (Variable N makes sure they are'nt reduced more than once per iteration.)
C
	IF(ITER.NE.0.AND.SUMSQ.GT.SUMSQOLD.AND.N.EQ.0) THEN
	FACTOR=MAX(.2*SUMSQOLD/SUMSQ,.1)
	I=0
	DO 8 J=1,NP
	IF(LOCKED(J)) GOTO 8
	I=I+1
	PAR(J)=PAROLD(J)+FACTOR*ZPARAM(I)
8	CONTINUE
	N=1
	GOTO 44
	END IF

C--- Renormalization

	IF(NSOU.NE.1.AND.ITER.NE.0) THEN
	   DO 109 ISOU=2,NSOU
	      DO 107 K=IFIRST(ISOU),IFIRST(ISOU+1)-1
107	      Y0(K)=Y(K)-FNORM(ISOU)    ! = original, unnormalized values
	      BESTSSQ=1.E30
	      DO NN=-100,100
	         FN=FNORM(ISOU)+LOG(1.+NN*.005)
	         SSQ=0.
	         DO 105 K=IFIRST(ISOU),IFIRST(ISOU+1)-1
	         Y(K)=FN+Y0(K)
105	         SSQ=SSQ+((FITFUN(X(K))-Y(K))/DY(K))**2
	         IF(SSQ.LT.BESTSSQ) THEN
	            BESTFN=FN
	            BESTSSQ=SSQ
	         END IF
	      END DO
	      FNORM(ISOU)=BESTFN
	      DO 108 K=IFIRST(ISOU),IFIRST(ISOU+1)-1
108	      Y(K)=BESTFN+Y0(K)
109      write(*,*)'Data set #',ISOU,
     1  ':  Normalization factor set to',EXP(BESTFN)
	END IF

C---------- Interrupt and wait for instructions

	write(*,*)'-----------------------------------------------------'
	write(*,*)ITER,' iterations performed         chisquare =',SUMSQ
	write(*,*)' '
	write(*,*)'Parameter #     New value     % change'
	IF(ITER.NE.0) THEN
	DO J=1,NP
	IF(PAROLD(J).NE.0.) write(*,*)J,PAR(J),100.*(PAR(J)/PAROLD(J)-1.)
	IF(PAROLD(J).EQ.0.) write(*,*)J,PAR(J)
	END DO
	END IF
	write(*,70)
70	FORMAT('$Go on (1) or stop (0)? ')
	read(*,*)INSTR
C
C---------- Save best parameters (= those with lowest sum-of-squares)
C
19	IF(ITER.EQ.0.OR.SUMSQ.LT.SUMSQMIN) THEN
	SUMSQMIN=SUMSQ
	DO 47 J=1,NP
47	PARBEST(J)=PAR(J)
	ITERBEST=ITER
	I=0
	DO 31 L=1,NP
	IF(LOCKED(L)) GOTO 31
	K=I
	I=I+1
	DO 51 J=L,NP
	IF(.NOT.LOCKED(J)) K=K+1
51	IF(.NOT.LOCKED(J)) ABEST(L,J)=ZA(I,K)
31	CONTINUE
	END IF
C
C---------- Stop if requested (instruction "0")
C
	IF(INSTR.EQ.0) GOTO 45
C
C---------- Matrix elements for linearized least-squares fit
C
	ITER=ITER+1           ! ITER =  no. of iterations performed
	DO 32 I=1,NPARAM
	ZB(I)=0.
	DO 32 J=1,NPARAM
32	ZA(I,J)=0.
	DO 90 K=1,MCH2
	CALL FUN_DERIVATIVE(X(K))
	I=0
	DO 33 L=1,NP
	IF(LOCKED(L)) GOTO 33
	I=I+1
	ZB(I)=ZB(I)+(Y(K)-FITFUN(X(K)))*DERIV(I)/DY(K)**2
	CALL FO(*11)       ! Jump out on overflow
	DO 333 J=I,NPARAM
	ZA(I,J)=ZA(I,J)+DERIV(I)*DERIV(J)/DY(K)**2
	CALL FO(*11)       ! Jump out on overflow
333   continue
33	CONTINUE
90	CONTINUE
	DO 36 I=2,NPARAM   !
	DO 36 J=1,I-1      ! Matrix is symmetric
36	ZA(I,J)=ZA(J,I)    !
C
C---------- New parameter values
C
	DO 43 J=1,NP           ! Save old parameter values for test of
43	PAROLD(J)=PAR(J)       ! whether SUMSQ increases 
	CALL SETLINEQ
	I=0
	DO 34 J=1,NP
	IF(LOCKED(J)) GOTO 34
	I=I+1
	PAR(J)=PAR(J)+ZPARAM(I)
34	CONTINUE
	GOTO 35
C-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X END OF ITERATION LOOP
C---------- Recall best values
C
45    continue
cCALL lib$revert      ! Disable overflow condition handler
	DO 48 J=1,NP
48	PAR(J)=PARBEST(J)
C
C---------- Write number of iterations and chi-squared in journal file
C
	IF(OUT.NE.' ') WRITE(3,65,ERR=80) ITER,ITERBEST,SUMSQMIN
65    FORMAT(/I4,' iterations performed'/' Best values reached after'
     1 ,I4,' iterations,       CHISQ=',F8.4//)
80	S=MAX(1.,SUMSQMIN)
	DO 360 I=2,NP            !
	DO 360 J=1,I-1           ! Matrix is symmetric
360	ABEST(I,J)=ABEST(J,I)    !
	DO 399 I=1,NP
	DO 399 J=1,NP
399	ZA(I,J)=S*ABEST(I,J)   ! Correlation matrix
C
C---------- Write results (= best values) in journal file and on screen
C
c JIW	DO 713 NUNIT=3,5,2
	IF(OUT.EQ.' '.AND.NUNIT.EQ.3) GOTO 713
	WRITE(3,718)
	WRITE(*,718)
718	FORMAT(//' Fitted parameter values:')
	DO 705 J=1,NP
705	WRITE(3,95) J,PAR(J),SQRT(ABS(SNGL(ZA(J,J))))
	WRITE(*,95) J,PAR(J),SQRT(ABS(SNGL(ZA(J,J))))
95	FORMAT(3X,'PAR(',I2,') = ',E15.5,' +/-',E15.5)
	WRITE(3,714)
	WRITE(*,714)
714	FORMAT(//' Correlation matrix:')
	DO 707 J=1,NP
707	WRITE(3,715) (SNGL(ZA(J,I)),I=1,NP)
	WRITE(*,715) (SNGL(ZA(J,I)),I=1,NP)
715   FORMAT(1X,E13.3,$)
c715   FORMAT(1X,<NP>E13.3)
	IF(NUNIT.EQ.5) THEN
	   write(*,719)
719	   FORMAT(//'$Type <RETURN> for more: ')
	   read(*,722)ANS
	   ANS=upcase(ANS)
722	   FORMAT(A1)
	END IF
	WRITE(3,716)
	WRITE(*,716)
716	FORMAT(//'     Energy       Efficiency     Eff. error     value
     1 of      chisquare'/48X,'fitted func.  contrib.')
	DO 708 K=1,MCH2
	EFF=EFF0*EXP(Y(K))
708	WRITE(3,*)
     1 E0*EXP(X(K)),EFF,EFF*DY(K),EFF0*EXP(FITFUN(X(K))),
     1 ((Y(K)-FITFUN(X(K)))/DY(K))**2
	WRITE(*,*)
     1 E0*EXP(X(K)),EFF,EFF*DY(K),EFF0*EXP(FITFUN(X(K))),
     1 ((Y(K)-FITFUN(X(K)))/DY(K))**2
713   CONTINUE

C--- TOP DRAWER file for plot of efficiency curve

	write(*,514)
514	FORMAT(/' Want a plot?  Then choose a name for
     1 the TOPDRAWER file.'/'$If not, type <RETURN>: ')
	read(*,7)NAME
7	FORMAT(A50)
	IF(NAME.NE.' ') THEN
	   write(*,310)
310	   FORMAT('$Header text: ')
	   read(*,311)HEADER
311	   FORMAT(A45)
	   SYMBOL(1)='3'
	   IF(NSOU.NE.1) THEN
		write(*,*)'TOPDRAWER plotting symbols 0 thru 9 are available,'
		write(*,*)'e.g.  2 = diamond,  3 = square,  9 = octagon'
	      DO 321 ISOU=1,NSOU
		write(*,320)ISOU
320	      FORMAT('$Which symbol for data set #',I2,'? ')
321         read(*,322)SYMBOL(ISOU)
322	      FORMAT(A1)
	   END IF
	   OPEN(1,file=NAME,status='NEW')
	   WRITE(1,*) 'SET DEVICE ''QMS1200'''
	   WRITE(1,*) 'SET FONT DUPLEX'
	   WRITE(1,*) 'SET SCALE X LOG Y LOG'
	   WRITE(1,*) 'TITLE BOTTOM ''E0G1 (keV)'''
	   WRITE(1,*)         'CASE '' XGX      '''
	   WRITE(1,*) 'TITLE LEFT ''Relative efficiency'''
	   WRITE(1,*) 'TITLE TOP ''',HEADER,''''
	   WRITE(1,*) 'SET ORDER X Y DY'
	   EMIN=E0*EXP(X(1))
	   EMAX=EMIN
	   DO 323 ISOU=1,NSOU
	   WRITE(1,*) 'SET SYMBOL ',SYMBOL(ISOU),'O SIZE 1.2'
	   DO 615 K=IFIRST(ISOU),IFIRST(ISOU+1)-1   !
	   ENERGY=E0*EXP(X(K))
	   IF(ENERGY.LT.EMIN) EMIN=ENERGY
	   IF(ENERGY.GT.EMAX) EMAX=ENERGY
	   EFF=EFF0*EXP(Y(K))                 !
615	   WRITE(1,*) ENERGY,EFF,EFF*DY(K)    ! Data points
323	   WRITE(1,*) 'PLOT'                  !
	   XRANGE=LOG(EMAX/E0)-LOG(EMIN/E0)
	   XLO=LOG(EMIN/E0)-.1*XRANGE
	   XHI=LOG(EMAX/E0)+.1*XRANGE
	   STEP=XRANGE/NPLOTPOINTS
	   DO 635 XX=XLO,XHI,STEP                      !
635	   WRITE(1,*) E0*EXP(XX),EFF0*EXP(FITFUN(XX))  ! Fitted curve
	   WRITE(1,*) 'JOIN'                           !
	   CLOSE(1)
	END IF
	RETURN

C----------  Error messages

11    write(*,720)
720	FORMAT('$NUMERIC OVERFLOW - DO YOU WISH
     1 TO TRY OTHER INITIAL VALUES?  Y/N: ')
	IF(OUT.NE.' ') WRITE(3,100)
100	FORMAT(' MISSION IMPOSSIBLE - NUMERIC OVERFLOW!')
	read(*,7)NAME
	IF(NAME.EQ.'Y') GOTO 721
	write(*,*)'OK.  SORRY THAT THIS COMPUTER''S CAPACITY WAS INADEQUATE
     2 FOR YOUR NEEDS.'
	RETURN
	END

*******************************************************************************

	SUBROUTINE FUN_DERIVATIVE(X)
C
C       Calculates DERIV(K) = derivative of FITFUN(X) with respect to PAR(J)
C	Abramowitz-Stegun p. 883:  4-point Lagrange interpolation with p=0
C	and step length h=STEP
C	NOTE:  K and J correspond to the same parameter, but K numbers the
C	parameters to be varied (K=1...NPARAM), while J numbers all parameters
C	(J=1...NP).
C
	PARAMETER (MATS=30,MAXPOINTS=8192,MAXSOU=9)
	COMMON /FUNF/ PAR(MATS),DERIV(MATS),NP,LOCKED(MATS),XX(MAXPOINTS),
     1 YY(MAXPOINTS),DYY(MAXPOINTS),
     1 MCH2,IPOW,IDEG,PW,WS,IPW,IWS,IFIRST(MAXSOU+1),FNORM(MAXSOU),NSOU
	logical LOCKED,PW,WS
	DIMENSION PAR0(MATS)
	K=0
	DO 1 J=1,NP
	IF(LOCKED(J)) GOTO 1
	K=K+1
	STEP=.001*PAR(J)
	IF(STEP.EQ.0.) STEP=.001
	IF(J.EQ.1) STEP=.1
	FX=FITFUN(X)         ! f(x)
	PAR0(J)=PAR(J)
	PAR(J)=PAR0(J)+STEP
	FXH=FITFUN(X)        ! f(x+h)
	PAR(J)=PAR0(J)+2.*STEP
	FX2H=FITFUN(X)       ! f(x+2h)
	PAR(J)=PAR0(J)-STEP
	FX_H=FITFUN(X)       ! f(x-h)
	DERIV(K)=(FXH-FX_H/3.-.5*FX-FX2H/6.)/STEP
	PAR(J)=PAR0(J)
1	CONTINUE
	RETURN
	END

*******************************************************************************

C   FLOATING OVERFLOW ERROR HANDLER

c	FUNCTION IFO(SIGARGS,MECHARGS)
c	COMMON /HANDLER/ ISIG
c	INTEGER SIGARGS(2),MECHARGS(5)
c      INCLUDE 'SYS$LIBRARY:SIGDEF'
C	INCLUDE 'SYS$LIBRARY:FORDEF'
c      INCLUDE 'SYS$LIBRARY:MTHDEF'
c	ISIG=SIGARGS(2)
c	IF(SIGARGS(2).EQ.SS$_FLTOVF_F
c    1 SIGARGS(2).EQ.MTH$_FLOOVEMAT) THEN
c	MECHARGS(4)=0
c	MECHARGS(5)=0
c	IFO=SS$_CONTINUE
c	ELSE
c	IFO=SS$_RESIGNAL
c	END IF
c	RETURN
c	END

	SUBROUTINE FO(*)
	COMMON /HANDLER/ ISIG
	IF(ISIG.NE.0) THEN
	ISIG=0
	RETURN 1
	END IF
	RETURN
	END

*******************************************************************************

	FUNCTION ATT(X)     ! Exponent of attenuation factor
C
C       X = ln(E/E0)    where E = gamma energy
C       THICKN(j) = thickness of absorber #j [cm]
C    The interpolated attenuation coefficient [cm-1] for absorber #j
C    at energy E(n) is      mu = MU0 * EXP(SPLCURVE(j,'U',X))
C                   or      mu = MU0 * EXP(SPLCURVE(j,'L',X))
C
	PARAMETER (NABSORBERS=9,NENERGIES=20,MATS=30)
	COMMON /LOGTRANS/ E0,MU0,EFF0,OUT
	COMMON /SPL/
     1 X_SPL(MATS),Y_SPL(NABSORBERS,MATS),N_SPL,D_SPL(MATS),
     1 ZZ_L(NABSORBERS,MATS),ZZ_U(NABSORBERS,MATS),
     1 THICKN(NABSORBERS),MU_L(NABSORBERS,NENERGIES),
     1 MU_U(NABSORBERS,NENERGIES),E(NENERGIES),EDGE(NABSORBERS)
	REAL*4 MU_L,MU_U
	REAL*8 ZZ_L,ZZ_U
	CHARACTER OUT*50
	ATT=0.
	DO J=1,NABSORBERS
	   IF(THICKN(J).NE.0.) THEN
	      IF(X.GT.EDGE(J)) THEN
	         ATT =ATT + THICKN(J) * MU0 * EXP(SPLCURVE(J,'U',X))
	      ELSE
	         ATT = ATT + THICKN(J) * MU0 * EXP(SPLCURVE(J,'L',X))
	      END IF
	   END IF
	END DO
	RETURN
	END

*******************************************************************************

	FUNCTION FITFUN(X) 
C	
C	FITFUN = fitted function
C	Your parameters are A(1) through A(n), with n up to MAXPAR.
C
C       X = ln(E/E0)    where E = gamma energy
C
	PARAMETER (MATS=30,MAXPOINTS=8192,MAXSOU=9)
	COMMON /LOGTRANS/ E0,MU0,EFF0,OUT
	COMMON /FUNF/ A(MATS),DERIV(MATS),NP,LOCKED(MATS),XX(MAXPOINTS),
     1 YY(MAXPOINTS),DYY(MAXPOINTS),
     1 MCH2,IPOW,IDEG,PW,WS,IPW,IWS,IFIRST(MAXSOU+1),FNORM(MAXSOU),NSOU
	logical LOCKED,PW,WS
	CHARACTER OUT*50
	POLYNOMIAL=0.
	DO 1 I=1,IDEG+1
1	POLYNOMIAL   =   POLYNOMIAL  +  A(I) * X**(I-1)
	FITFUN  =  -ATT(X) + POLYNOMIAL
	IF(WS)  FITFUN = FITFUN - LOG(1.+EXP((A(IWS)-E0*EXP(X))/A(IWS+1)))
	IF(PW)  FITFUN = FITFUN + A(IPW)/(X**IPOW)
	RETURN
	END

C******************************************************************************
C******************************************************************************

	SUBROUTINE GREMLIN_CALC
	PARAMETER(MATP=500,MATS=30,NABSORBERS=9,NENERGIES=20,
     1 MAXPOINTS=8192)
	PARAMETER (MAXSOU=9)
	COMMON /LOGTRANS/ E0,MU0,EFF0,OUT
	CHARACTER*50 FILNAM,OUT
	COMMON /MATRIX/ NP_P,N_P,DET,IBIGDET,X_P(MATP),Y_P(MATP),
     1 DY_P(MATP),P_P(MATS),A_P(MATS,MATS),B_P(MATS)
	REAL*8 X_P,Y_P,DY_P,P_P,A_P,B_P,ZZ_L,ZZ_U  ! _P denotes POLFIT variables
	COMMON /SPL/
     1 X_SPL(MATS),Y_SPL(NABSORBERS,MATS),N_SPL,D_SPL(MATS),
     1 ZZ_L(NABSORBERS,MATS),ZZ_U(NABSORBERS,MATS),
     1 THICKN(NABSORBERS),MU_L(NABSORBERS,NENERGIES),
     1 MU_U(NABSORBERS,NENERGIES),E_ATT(NENERGIES),EDGE(NABSORBERS)
	REAL*4 M1,M2,M3,M4,MU_L,MU_U,DER(MATS)
	COMMON /FUNF/ PAR(MATS),DERIV(MATS),NP,LOCKED(MATS),XX(MAXPOINTS),
     1 YY(MAXPOINTS),DYY(MAXPOINTS),
     1 MCH2,IPOW,IDEG,PW,WS,IPW,IWS,IFIRST(MAXSOU+1),FNORM(MAXSOU),NSOU
	logical LOCKED,PW,WS

c	type definiions for functions absent in standard Linux f77 libraries:
	real sind,asind,cosd,acosd

C           write(*,1987)
C1987		FORMAT('$Gamma #, exp #: ')
C           read(*,*)NOGAMMA,NOEXP

C--- Read calibration storage file

	write(*,203)
203	FORMAT(/'$Calibration storage file: ')
	read(*,6)FILNAM
C		IF(NOGAMMA.EQ.1) FILNAM='EFFCAL.G1'
C		IF(NOGAMMA.EQ.2) FILNAM='EFFCAL.G2'
C		IF(NOGAMMA.EQ.3) FILNAM='EFFCAL.G3'
C		IF(NOGAMMA.EQ.4) FILNAM='EFFCAL.G4'
C           write(*,*)FILNAM
	OPEN(1,file=FILNAM,status='OLD',ERR=300)
c      OPEN(1,file=FILNAM,status='OLD',READONLY,ERR=300)
	READ(1,*,ERR=304) THICKN
	CALL GREMLIN_ATT(1)     ! Set up attenuation curves
C                               ! (must be done before A_P is read)
	READ(1,*,ERR=304) IPOW,IDEG,IPW,IWS,EFF0,NP_GEFFIC
	READ(1,*,ERR=304) (PAR(I),I=1,NP_GEFFIC)
	READ(1,*,ERR=304) WS,PW
	DO 101 I=1,NP_GEFFIC
101	READ(1,*,ERR=304) (A_P(I,J),J=1,NP_GEFFIC)
	CLOSE(1)

C--- Output file

	write(*,5)
5	FORMAT(/'$Output file, or <RETURN> for no file: ')
	read(*,6)FILNAM
6	FORMAT(A50)
C		FILNAM=' '
	IF(FILNAM.NE.' ') OPEN(1,file=FILNAM,status='NEW')

C--- Input for kinematics

	write(*,10)
10	FORMAT(/' Non-relativistic two-body kinematics assumed.'/
     1' All energies and angles must be given in the lab system.'//
     1      '$PROJECTILE:         Mass (amu), energy (MeV): ')
	read(*,*)M1,E1
C		M1=80.
C		E1=195.
C           write(*,*)M1,E1
	write(*,11)
11	FORMAT('$TARGET:             Mass (amu): ')
	read(*,*)M2
C		M2=48.
C           write(*,*)M2
	write(*,12)
12	FORMAT('$RADIATING NUCLEUS:  Mass (amu), theta, phi (deg.): ')
	read(*,*)M3,TH3,PH3
C		M3=80.
C		IF(NOEXP.EQ.1) THEN
C		   TH3=23.844
C		   PH3=270.
C		ELSE IF(NOEXP.EQ.2) THEN
C		   TH3=32.357
C		   PH3=270.
C		ELSE IF(NOEXP.EQ.3) THEN
C		   TH3=32.45
C		   PH3=90.
C		ELSE IF(NOEXP.EQ.4) THEN
C		   TH3=23.95
C		   PH3=90.
C		ELSE IF(NOEXP.EQ.5) THEN
C		   TH3=36.148
C		   PH3=270.
C		ELSE IF(NOEXP.EQ.6) THEN
C		   TH3=36.631
C		   PH3=90.
C		END IF
C           write(*,*)M3,TH3,PH3
	write(*,13)
13	FORMAT('$Q-value (MeV): ')
	read(*,*)Q
C		Q=0.
C           write(*,*)Q

C--- Energy and speed of radiating nucleus

	M4=M1+M2-M3
	A=SQRT(M1*M3*E1)*COSD(TH3)/(M3+M4)
	B=((M4-M1)*E1+M4*Q)/(M3+M4)
	A2B=A*A+B
	IF(B.GE.0.) THEN
	   E3=(A+SQRT(A2B))**2
	ELSE IF(B.EQ.0.) THEN
	   IF(TH3.LE.90.) THEN
	      E3=4.*A*A
	   ELSE
		write(*,*)'KINEMATICALLY IMPOSSIBLE.  MAX. ANGLE IS 90 DEGREES.'
	      RETURN
	   END IF
	ELSE
	   IF(A.GE.0.) THEN
	      THMAX=ACOSD(SQRT((M3+M4)*(M1-M4*(1.+Q/E1))/(M1*M3)))
	      IF(TH3.LT.THMAX) THEN
	         E3_1=(A+SQRT(A2B))**2
	         E3_2=(A-SQRT(A2B))**2
	         E4_1=E1-E3_1+Q
	         E4_2=E1-E3_2+Q
	         TH4_1=ASIND(SIND(TH3)*SQRT(M3*E3_1/(M4*E4_1)))
	         TH4_2=ASIND(SIND(TH3)*SQRT(M3*E3_2/(M4*E4_2)))
	         IF(SQRT(M1*E1).LT.COSD(TH3)*SQRT(M3*E3_1)) TH4_1=180.-TH4_1
	         IF(SQRT(M1*E1).LT.COSD(TH3)*SQRT(M3*E3_2)) TH4_1=180.-TH4_2
		   write(*,191)IFIX(M3),IFIX(M4),E3_1,TH4_1,E3_2,TH4_2
191	         FORMAT(/
     1      ' Solution #    Energy (mass',I4,')    Theta (mass',I4,')'/
     1        5X,'1',12X,F10.3,8X,F10.3/5X,'2',12X,F10.3,8X,F10.3/
     1        /'$Which solution? ')
		   read(*,*)ISOL
C		ISOL=1
C           write(*,*)ISOL
	         E3=E3_1
	         IF(ISOL.EQ.2) E3=E3_2
	      ELSE
		   write(*,*)'KINEMATICALLY IMPOSSIBLE.'
	         RETURN
	      END IF
	   ELSE
		write(*,*)'KINEMATICALLY IMPOSSIBLE.'
	      RETURN
	   END IF
	END IF
	write(*,*)'Lab energy of radiating nucleus =',E3
	VC=.0463364*SQRT(E3/M3)
	write(*,*)'v/c =',VC

C--- Doppler shift

	write(*,2)
2	FORMAT(/'$GAMMA DETECTOR:   Theta, phi (deg.): ')
	read(*,*)THG,PHG
C		IF(NOGAMMA.EQ.1) THEN
C		   THG=140.5
C		   PHG=90.
C		ELSE IF(NOGAMMA.EQ.2) THEN
C		   THG=30.
C		   PHG=90.
C		ELSE IF(NOGAMMA.EQ.3) THEN
C		   THG=60.
C		   PHG=270.
C		ELSE IF(NOGAMMA.EQ.4) THEN
C		   THG=130.
C		   PHG=270.
C		END IF
C           write(*,*)THG,PHG
	COSALPHA = SIND(THG) * SIND(TH3) * COSD(PHG-PH3)  +
     1  COSD(THG) * COSD(TH3)
	write(*,*)'Angle between gamma ray and radiating nucleus =',
     1 ACOSD(COSALPHA),' deg.'
	SHIFT=SQRT(1.-VC*VC)/(1.-VC*COSALPHA)
	write(*,*)'Doppler shift factor =',SHIFT

C--- Printout

	IF(FILNAM.NE.' ') THEN
	WRITE(1,*)
     1 'Mass (amu), energy (MeV), theta, phi (deg.) ',
     1 'of radiating nucleus:'
	WRITE (1,*) M3,E3,TH3,PH3
	WRITE(1,*) 'Theta, phi (deg.) of gamma detector: ',THG,PHG
	WRITE(1,*) 'v/c =',VC
	WRITE(1,*) 'Angle between gamma ray and radiating nucleus =',
     1 ACOSD(COSALPHA),' deg.'
	WRITE(1,*) 'Doppler shift factor =',SHIFT
	END IF

C--- Minimum allowed relative efficiency error

	write(*,711)
711	FORMAT(' Minimum allowed relative error in the efficiency'/
     1 '$(e.g. for 5% type 0.05): ')
	read(*,*)EFFERRMIN
C		EFFERRMIN=.05
C           write(*,*)EFFERRMIN

C--- Relative intensity

3     write(*,4)
4	FORMAT(/'$Transition
     1 energy (keV), area, area error (0 0 0 to stop): ')
	read(*,*)E,A,DA
	IF(A.EQ.0.) RETURN
	ESH=SHIFT*E
	ELOG=LOG(ESH/E0)
	EFF=EFF0*EXP(FITFUN(ELOG))
	RI=A/EFF
	write(*,*)'Doppler-shifted energy =',ESH,' keV'

C--- Derivatives of efficiency with respect to parameters of fit

	DO 14 I=1,IDEG+1
14	DER(I)=EFF*ELOG**(I-1)
	IF(WS) THEN
	   EXPONENT=(ESH-PAR(IWS))/PAR(IWS+1)
	   DER(IWS)=-EFF/(PAR(IWS+1)*(1.+EXP(EXPONENT)))
	   DER(IWS+1)=EXPONENT*DER(IWS)
	END IF
	IF(PW) DER(IPW)=EFF/(ELOG**IPOW)

C--- Intensity error

	DEFF2=0.
	DO 15 I=1,NP_GEFFIC
	DO 15 J=1,NP_GEFFIC
15	DEFF2   =   DEFF2  +  DER(I) * DER(J) * A_P(I,J)    ! eff. error squared
	DEFF=MAX(DEFF2/(EFF*EFF),EFFERRMIN**2)
	write(*,*)'Relative efficiency =',EFF,' +-',SQRT(DEFF2)
	DI = RI * SQRT((DA/A)**2  +  DEFF)
	write(*,*)'Relative intensity =',RI,' +-',DI,
     1 '       (',NINT(100.*DI/RI),' %)'
	GOTO 3

C--- Error messages

300   write(*,*)'FILE NOT FOUND, OR PROTECTED',CHAR(7)
	RETURN
304   write(*,*)'READ ERROR',CHAR(7)
	RETURN
	END

C******************************************************************************
C******************************************************************************

	SUBROUTINE SPLINE(JA,LU)     ! JA = absorber number
C  Input:  N points  (X(i),Y(i)), i=1...N
C  Output:  Coefficients Z(i), i=1...N,  for cubic spline polynomial
C  Instructions for use:  You must have the COMMON block /SPL/ in the calling
C                         program, and supply values for X(i), Y(i), and N.
C                         Then, after doing CALL SPLINE, you can use the
C                         function SPLCURVE(x) to get a smooth curve through
C                         the points.
	PARAMETER (NABSORBERS=9,MATP=500,MATS=30,NENERGIES=20)
	COMMON /SPL/ X(MATS),Y(NABSORBERS,MATS),N,D(MATS),
     1 ZZ_L(NABSORBERS,MATS),ZZ_U(NABSORBERS,MATS),
     1 THICKN(NABSORBERS),MU_L(NABSORBERS,NENERGIES),
     1 MU_U(NABSORBERS,NENERGIES),E(NENERGIES),EDGE(NABSORBERS)
	COMMON /MATRIX/ NP,NPOINTS,DET,IBIGDET,
     1 ZX(MATP),ZY(MATP),ZDY(MATP),Z(MATS),A(MATS,MATS),B(MATS)
	REAL*4 MU_L,MU_U
	REAL*8 ZX,ZY,ZDY,Z,A,B,ZZ_L,ZZ_U
	CHARACTER LU*1
	NPOINTS=N

C  Arrange points in order of increasing X(i)

	DO J=1,N-1
	DO K=J,N
	IF(X(K).LT.X(J)) THEN
	SAVE=X(J)
	X(J)=X(K)
	X(K)=SAVE
	SAVE=Y(JA,J)
	Y(JA,J)=Y(JA,K)
	Y(JA,K)=SAVE
	END IF
	END DO
	END DO

C  Calculate differences D(i)

	DO 1 K=1,N-1
1	D(K)=X(K+1)-X(K)

C  Zero arrays (important!)

	DO 2 J=1,MATS
	B(J)=0.
	DO 2 K=1,MATS
2	A(J,K)=0.

C  Set up set of linear equations

	A(1,1)=1./D(1)
	A(1,2)=-(1./D(1)+1./D(2))
	A(1,3)=1./D(2)
	DO 3 K=2,N-1
	A(K,K-1)=D(K-1)
	A(K,K)=2.*(D(K-1)+D(K))
	A(K,K+1)=D(K)
3	B(K)=6.*((Y(JA,K+1)-Y(JA,K))/D(K)-
     1 (Y(JA,K)-Y(JA,K-1))/D(K-1))
	A(N,N-2)=1./D(N-2)
	A(N,N-1)=-(1./D(N-2)+1./D(N-1))
	A(N,N)=1./D(N-1)

C  Solve set of equations

	CALL SETLINEQ      ! Gives solution vector Z(i)
	IF(LU.EQ.'L') THEN
	DO 7 K=1,N
7	ZZ_L(JA,K)=Z(K)
	ELSE
	DO 8 K=1,N
8	ZZ_U(JA,K)=Z(K)
	END IF
	RETURN
	END

C******************************************************************************

	FUNCTION SPLCURVE(J,LU,XARG)
C   Calculates cubic spline curve mu(E) for absorber #J
	PARAMETER (NABSORBERS=9,MATS=30,NENERGIES=20)
	COMMON /SPL/ X(MATS),Y(NABSORBERS,MATS),N,D(MATS),
     1 ZZ_L(NABSORBERS,MATS),ZZ_U(NABSORBERS,MATS),
     1 THICKN(NABSORBERS),MU_L(NABSORBERS,NENERGIES),
     1 MU_U(NABSORBERS,NENERGIES),E(NENERGIES),EDGE(NABSORBERS)
	REAL*4 MU_L,MU_U
	REAL*8 ZZ_L,ZZ_U
	CHARACTER LU*1
	K=1
3	K=K+1
	IF(K.GE.N) GOTO 1
	IF(XARG.GT.X(K)) GOTO 3
1	K=K-1
	IF(LU.EQ.'L') THEN
	SPLCURVE=
     1 (ZZ_L(J,K)*(X(K+1)-XARG)**3+
     1 ZZ_L(J,K+1)*(XARG-X(K))**3)/(6.*D(K))+
     1 (X(K+1)-XARG)*(Y(J,K)/D(K)-ZZ_L(J,K)*D(K)/6.)+
     1 (XARG-X(K))*(Y(J,K+1)/D(K)-ZZ_L(J,K+1)*D(K)/6.)
	ELSE
	SPLCURVE=
     1 (ZZ_U(J,K)*(X(K+1)-XARG)**3+
     1 ZZ_U(J,K+1)*(XARG-X(K))**3)/(6.*D(K))+
     1 (X(K+1)-XARG)*(Y(J,K)/D(K)-ZZ_U(J,K)*D(K)/6.)+
     1 (XARG-X(K))*(Y(J,K+1)/D(K)-ZZ_U(J,K+1)*D(K)/6.)
	END IF
	RETURN
	END
            SUBROUTINE POLFIT(*,*,*)
C
C   A. Kavka  1982-07-06
C
C   Fits polynomial of degree IDEG to points (X(i),Y(i))
C   NP = number of points,  DY(i) = error in Y(i)
C
C                           N       j-1
C   The polynomial is  Y = SUM P(j)X          (N=IDEG+1)
C                          j=1
C
C   Alternative returns:  RETURN   = success
C                    RETURN 1 = failure (singular matrix)
C                    RETURN 2 = failure (overflow in parameter calculation)
C                    RETURN 3 = correct parameters, but wrong
C                             parameter-error values (overflow in
C                             error calculation)
C
      PARAMETER (MATP=500,MATS=30) !Max. no. of data points & max. matrix size
      COMMON /MATRIX/ NP,N,DET,IBIGDET,
     1 X(MATP),Y(MATP),DY(MATP),P(MATS),A(MATS,MATS),B(MATS)
      REAL*8 X,Y,DY,P,A,B,XX,XMEAN,W,YMEAN
      IER=0
      DO 18 K=1,NP
      IF(DY(K).EQ.0.) GOTO 19
18    CONTINUE
      GOTO 14
19    DO 20 K=1,NP
20    DY(K)=1.
C
C========================= PARAMETERS =========================================
C
C----------  Coordinate transformations to reduce large x and y values
C
14    XMEAN=0.
      YMEAN=0.
      DO 10 K=1,NP
      XMEAN=XMEAN+X(K)
10    YMEAN=YMEAN+Y(K)
      XMEAN=XMEAN/NP
      IF(XMEAN.EQ.0.) XMEAN=1.
      YMEAN=YMEAN/NP
      IF(YMEAN.EQ.0.) YMEAN=1.
      DO 13 K=1,NP
      X(K)=X(K)/XMEAN
13    Y(K)=Y(K)/YMEAN
C
C----------  Calculate matrix elements
C
12    DO 1 L=1,N
      B(L)=0.
      DO 1 J=L,N
1     A(L,J)=0.
      DO 2 K=1,NP
      W=1./(DY(K)*DY(K))        ! Error weighting
      DO 2 L=1,N
      IF(X(K).EQ.0..OR.Y(K).EQ.0.) GOTO 21
      IF((L-1)*LOG10(ABS(X(K)))+LOG10(ABS(Y(K)))+LOG10(W).GT.38.2)
     1 RETURN 2+IER
21    IF(X(K).NE.0.) XX=W*X(K)**(L-1)*Y(K)
      IF(X(K).EQ.0.) XX=0.
      IF(B(L).GT.1.7D38-XX) RETURN 2+IER
      B(L)=B(L)+XX
      DO 2 J=L,N
      IF(X(K).EQ.0.) THEN
      XX=0.
      ELSE
      IF((L+J-2)*LOG10(ABS(X(K)))+LOG10(W).GT.38.2) RETURN 2+IER
      XX=W*X(K)**(L+J-2)
      END IF
      IF(A(L,J).GT.1.7D38-XX) RETURN 2+IER
2     A(L,J)=A(L,J)+XX
C
C----------  Symmetrical matrix
C
      DO 6 L=2,N
      DO 6 J=1,L-1
6     A(L,J)=A(J,L)
      IF(IER.EQ.1) GOTO 11
C
C----------  Calculate parameters
C
      CALL SETLINEQ
      DO 16 K=1,NP
      X(K)=X(K)*XMEAN
16    Y(K)=Y(K)*YMEAN
      IF(DET.EQ.0.) RETURN 1      ! Singular matrix
      DO 17 J=1,N
17    P(J)=P(J)*YMEAN*XMEAN**(1-J)
C
C========================= PARAMETER ERRORS ===================================
C
C----------  Calculate matrix elements
C
      IER=1
      GOTO 12
C
C----------  Invert matrix
C
11    CALL MATINV
      RETURN
      END

*******************************************************************************

      SUBROUTINE SETLINEQ
C
C      Solves set of N linear equations:   AP = B
C
      PARAMETER (MATP=500,MATS=30)
      COMMON /MATRIX/ NP,N,DET,IBIGDET,
     1 X(MATP),Y(MATP),DY(MATP),P(MATS),A(MATS,MATS),B(MATS)
      REAL*8 X,Y,DY,P,A,B
C
C                                  -1
C----------  Find inverse matrix  A
C
      CALL MATINV
C
C                                       -1
C----------  Find solution vector  P = A  B
C
      DO 1 I=1,N
      P(I)=0.
      DO 1 K=1,N
1     P(I)=P(I)+A(I,K)*B(K)
      RETURN
      END

*******************************************************************************

      SUBROUTINE MATINV
C
C      by Gunnar Janson
C
C      INVERTS MATRIX AND CALCULATES ITS DETERMINANT
C
C       USAGE
C        CALL MATINV
C        If only determinant is needed:  CALL DETERM
C
C      NOTE:  Determinants larger than 1.7E38 cannot be calculated.
C             If such a value occurs, IBIGDET is set = 1 and a wrong
C             determinant value is returned.
C
C      VARIABLES
C        A   = INPUT MATRIX WHICH IS REPLACED BY ITS INVERSE
C        N   = DEGREE OF MATRIX (ORDER OF ITS DETERMINANT)
C        DET = DETERMINANT OF INPUT MATRIX
C
      PARAMETER (MATP=500,MATS=30)
      COMMON /MATRIX/ NP,N,DET,IBIGDET,
     1 X(MATP),Y(MATP),DY(MATP),P(MATS),A(MATS,MATS),B(MATS)
      REAL*8 X,Y,DY,P,A,B,AMAX,SAVE
      DIMENSION IK(50),JK(50)
      IDET=0
      IBIGDET=0
      GOTO 10
      ENTRY DETERM
      IDET=1
   10 DET=1.
   11 DO 100 K=1,N
C
C        FIND LARGEST ELEMENT A(J,K) IN REST OF MATRIX
C
      AMAX=0.
   21 DO 30 I=K,N
      DO 30 J=K,N
   23 IF(DABS(AMAX)-DABS(A(I,J))) 24,30,30
   24 AMAX=A(I,J)
      IK(K)=I
      JK(K)=J
   30 CONTINUE
C
C        INTERCHANGE ROWS AND COLUMNS TO PUT AMAX IN A(K,K)
C
   31 IF(AMAX) 41,32,41
   32 DET=0.
      RETURN     ! Singular matrix
   41 I=IK(K)
      IF(I-K) 21,51,43
   43 DO 50 J=1,N
      SAVE=A(K,J)
      A(K,J)=A(I,J)
   50 A(I,J)=-SAVE
   51 J=JK(K)
      IF(J-K) 21,61,53
   53 DO 60 I=1,N
      SAVE=A(I,K)
      A(I,K)=A(I,J)
   60 A(I,J)=-SAVE
C
C        ACCUMULATE ELEMENTS OF INVERSE MATRIX
C
   61 DO 70 I=1,N
      IF(I-K) 63,70,63
   63 A(I,K)=-A(I,K)/AMAX
   70 CONTINUE
   71 DO 80 I=1,N
      DO 80 J=1,N
      IF(I-K) 74,80,74
   74 IF(J-K) 75,80,75
   75 A(I,J)=A(I,J)+A(I,K)*A(K,J)
   80 CONTINUE
   81 DO 90 J=1,N
      IF(J-K) 83,90,83
   83 A(K,J)=A(K,J)/AMAX
   90 CONTINUE
      A(K,K)=1./AMAX
      IF(DET.EQ.0.) GOTO 150
      IF(LOG10(ABS(DET))+LOG10(ABS(AMAX))-38.2) 150,150,151
  151 IBIGDET=1
      DET=999999.    ! To make sure that DET isn't returned as zero when
C                    ! IBIGDET=1, so that calling program doesn't have to
C                    ! check IBIGDET to find out whether matrix is singular
      GOTO 100
  150 DET=DET*AMAX
  100 IF(IDET.EQ.1) RETURN
C
C        RESTORE ORDERING OF MATRIX
C
  101 DO 130 L=1,N
      K=N-L+1
      J=IK(K)
      IF(J-K) 111,111,105
  105 DO 110 I=1,N
      SAVE=A(I,K)
      A(I,K)=-A(I,J)
  110 A(I,J)=SAVE
  111 I=JK(K)
      IF(I-K) 130,130,113
  113 DO 120 J=1,N
      SAVE=A(K,J)
      A(K,J)=-A(I,J)
  120 A(I,J)=SAVE
  130 CONTINUE
      RETURN
      END
c
c
	character function upcase(a)
	character a
	i=ichar(a)
	if ((i.lt.97).or.(i.gt.122)) goto 100
	i=i-32
 100    upcase=char(i)
	return
	end

c	Linux libraries do not define these functions:

        real function sind(x)
        real x
        sind=sin(x/57.29578)
        return
        end

        real function cosd(x)
        real x
        cosd=cos(x/57.29578)
        return
        end

	real function asind(x)
	real x
	asind=asin(x)*57.29578
	return
	end

        real function acosd(x)
        real x
        acosd=acos(x)*57.29578
        return
        end
