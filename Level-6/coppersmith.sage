def coppersmith_howgrave_univariate(pol, modulus, beta, mm, tt, XX):
    
    dd = pol.degree()
    nn = dd * mm + tt

    polZ = pol.change_ring(ZZ)
    x = polZ.parent().gen()

    # compute polynomials
    gg = []
    for ii in range(mm):
        for jj in range(dd):
            gg.append((x * XX)**jj * modulus**(mm - ii) * polZ(x * XX)**ii)
    for ii in range(tt):
        gg.append((x * XX)**ii * polZ(x * XX)**mm)

    # construct lattice B
    BB = Matrix(ZZ, nn)

    for ii in range(nn):
        for jj in range(ii+1):
            BB[ii, jj] = gg[ii][jj]

    # LLL
    BB = BB.LLL()

    # transform shortest vector in polynomial
    new_pol = 0
    for ii in range(nn):
        new_pol += x**ii * BB[0, ii] / XX**ii

    # factor polynomial
    potential_roots = new_pol.roots()
    
    # test roots
    roots = []
    for root in potential_roots:
        if root[0].is_integer():
            result = polZ(ZZ(root[0]))
            if gcd(modulus, result) >= modulus^beta:
                roots.append(ZZ(root[0]))

    return roots

e = 5
N = 3665612238752088973428342512040280866180876521016748157676717987121762462558702989000030906031706869041772288316637853776541229449921758787761044652698362841759808868204706301539672683780672062357856481509380205841326089007126536659711979070365055685036739582065217508838960471544262444328591568687961
C = 2002776731791147482008293855985414629514416343617425956732332205554257917529763954463717568594184161313972970913553649436956175355992540246298982551186618697931991364226493252413758093608755890983806691775958872587851841100627086504054481949150860593382129553690618583893393393451873557454259534077799

# RSA known parameters
ZmodN = Zmod(N);

def break_RSA(p_str, max_length_M):
    global e, C, ZmodN

    p_binary_str = ''.join(['{0:08b}'.format(ord(x)) for x in p_str])

    for length_M in range(0, max_length_M+1, 4):          # size of the root

        # Problem to equation (default)
        P.<M> = PolynomialRing(ZmodN) #, implementation='NTL')
        pol = ((int(p_binary_str, 2)<<length_M) + M)^e - C
        dd = pol.degree()

        # Tweak those
        beta = 1                                
        epsilon = beta / 7                      
        mm = ceil(beta**2 / (dd * epsilon))     
        tt = floor(dd * mm * ((1/beta) - 1))    
        XX = ceil(N**((beta**2/dd) - epsilon))  

        roots = coppersmith_howgrave_univariate(pol, N, beta, mm, tt, XX)

        if roots:
            print "Root is :", ' {0:b}'.format(roots[0])
            return

    print 'No solution found\n'

if __name__ == "__main__":
    break_RSA("Wannabe_Eves: This door has RSA encryption with exponent 5 and the password is  ", 300)