ncode(m)=fromdigits(Vec(Vecsmall(m)),128);
decode(m)=Strchr(digits(m, 128));
[n,c] = readvec("input.txt");

\\ n=p*q pour pouvoir déchiffrer m nous recherchons p et q.
\\ Puisque notre n est un grand entier et n n'est composé que de deux facteurs on peut utiliser la méthode de rho -1 de Pollard.

factor_pollard(n)={
	i=1;
	a=Mod(3,n);
	j=1;
	while(j==1,
		a=a^i;
		j=gcd(lift(a-1),n); i=i+1);
	j; 
};

\\ Le symbole de Jacobi 

dechiffre(m, p, q) = {
	    
	    c=Mod(m[1],n);
	    j=m[2];
	    par=m[3];
	    m_p = c^((p+1)/4); \\ m mod p
	    m_q = c^((q+1)/4); \\ m mod q
	    \\ Bézout qui lie p et q.
	    b=gcdext(p, q);
	    u = b[1];
	    v = b[2];
	    s = n - m_q*u*p + m_p*v*q;
	    lift(s);
};


\\ Première facteur

p=factor_pollard(n);

\\ Second facteur

q=n/p;

\\ On déchiffre

d=dechiffre(c, p, q);

\\ On décode

print(decode(d));
