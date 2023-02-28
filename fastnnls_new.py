import numpy as np

def fastnnls_new(X,XtX,Xty,lamb,ss,tol):

    
    m,n = XtX.shape
    P = np.zeros(n, dtype=np.bool8)

    Z = (1-P).astype(np.bool8)
    
    x = np.zeros(n)
    z = np.ones(n)
    ZZ = Z
    iter = 0
    w = Xty+lamb-X.T@(X@x)*ss-np.sum(x)*lamb
    
    while(np.sum(Z==True)>0 and np.sum(w[ZZ]>tol)>0):
        print((np.sum(Z==True)>0 and np.sum(w[ZZ]>tol)>0))
        wmax,ind = np.max(w[ZZ]),np.argmax(w[ZZ])
        #ind = ZZ[ind]
        P[ind]=True
        Z[ind]=False
        PP =  np.argwhere(P==True).T[0]
        ZZ = np.argwhere(Z==True).T[0]

        nzz = ZZ.shape
        z[PP] = np.linalg.inv(X[:,PP].T@X[:,PP]*ss+lamb)@(Xty[PP]+lamb)
        z[ZZ] = 0

        print(ZZ)

        #print(z[PP])
        #print(Z)
        #print(np.sum(w[ZZ]>tol))

        """

        
        #print(np.sum(z[PP]<=tol))
        while (np.sum(z[PP]<=tol)>0):
            temp = z <= tol
            temp2 = P==True
            QQ = np.in1d(temp,temp2)
            QQ = QQ.astype(np.bool8)
            #print(QQ)
            alpha = np.min(x[QQ]/((x[QQ]-z[QQ])))
            #print(x[QQ]/((x[QQ]-z[QQ])))
            x = x + alpha*(z-x)
            ij = np.in1d(abs(x)<tol,P==True)
            indij = np.argwhere(ij==True).T[0]
            Z[indij] =True
            P[ij] = np.zeros_like(ij,dtype=bool)
            PP = np.argwhere(P==True).T[0]
            ZZ = np.argwhere(Z==True).T[0]
            nzz = ZZ.shape
            z[PP] = np.linalg.inv(X[:,PP].T@X[:,PP]*ss+lamb)@(Xty[PP]+lamb)
            z[ZZ] = 0
            #z = z.flatten()
            iter = iter + 1
        
        
        """


        

        x = z
        w = Xty+lamb-X.T@(X@x)*ss-np.sum(x)*lamb 
        print(x)
        print(w[ZZ])
        print((np.sum(Z==True)>0 and np.sum(w[ZZ]>tol)>0))







    return x,w