* Monte Carlo simulation
* Laura Magazzini: laura.magazzini@santannapisa.it

* Dynamic panel data model
* OLS is upward biased
* WG(FE) is downward biased
* IV-Anderson & Hsiao (1981) to get a consistent estimator
* GMM-Arellano & Bond (1991) to get a consistent estimator


clear
set mem 50m
set more off
pause on

version 9.2

set obs 1500
local T = 15
* T=10+5
   
gen id = (ceil(_n/`T'))
gen t = _n-`T'*(id-1)-10
* t va da -9 a 5
sort id t
tsset id t

set seed 1234

gen estgfe=.
gen estgols=.
gen estgiv=.
gen estgab1=.
gen estgab=.

gen estbfe=.
gen estbols=.
gen estbiv=.
gen estbab1=.
gen estbab=.

tsset id t

foreach repl of numlist 1(1)100  {  

   ** DATA GENERATING PROCESS
   **di "** MC repl " `repl'
   if `repl' == 1 {
		local prefix = "noisily"
   }
   else {
		local prefix = ""
   }

   quietly{
    * individual effect
    gen alphai=invnorm(uniform()) if t==-9
    by id: replace alphai = alphai[1]
    * idiosyncratic noise
    gen epsilonit=invnorm(uniform())

	* y & x
    gen y=0 if t==-9
	gen xsim = invnorm(uniform()) if t==-9
    forvalues ttt=-8(1)7 {
		replace xsim= 0.8*(L.xsim) + invnorm(uniform())*sqrt(0.9)    if t==`ttt'
		replace y= 0.5*(L.y) + 1*xsim + 1*alphai + 1*epsilonit if t==`ttt'
    }
    drop alphai epsilonit
   
    xtset id t

    gen y_1=L.y

    replace y=. if t<=0
    replace y_1=. if t<=0
    replace x=. if t<=0
   
    ** Within-group (FE) estimator
    `prefix' xtreg y y_1 x if t>0, fe i(id) 
    replace estgfe = _b[y_1] in `repl'
    replace estbfe = _b[x] in `repl'

    ** stimatore OLS
    `prefix' reg y y_1 x if t>0, robust cluster(id)
    replace estgols = _b[y_1] in `repl'
    replace estbols = _b[x] in `repl'

	** IV estimator - Anderson & Hsiao
	`prefix' ivregress 2sls D.y (D.y_1 = L2.y) D.x if t>0, robust cluster(id)
    replace estgiv = _b[D.y_1] in `repl'
    replace estbiv = _b[D.x] in `repl'
	
    ** GMM estimator (Arellano-Bond) -- one lag only
    `prefix'  xtabond y x if t>0, noconst maxldep(1)
	replace estgab1 = _b[LD.y] in `repl'
    replace estbab1 = _b[D.x] in `repl'

    ** GMM estimator (Arellano-Bond) -- all available lags
    `prefix' xtabond y x if t>0, noconst  
    replace estgab = _b[LD.y] in `repl'
    replace estbab = _b[D.x] in `repl'

    keep id t est* 
    sort id t
    estimates drop _all

  }

}

summ estg*

summ estb*

