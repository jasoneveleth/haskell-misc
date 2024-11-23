-- HOW TO RUN:
--      $ ghci gal.hs
--      *Main> |

-- OR
--      $ ghci gal.hs < gal.in

-- ^^ this is what it should look like

data Prim = Alpha | Beta | Root6 | Neg1 | One

-- how to print a "primitive"
instance Show Prim where
    show Alpha = "a"
    show Beta = "b"
    show Root6 = "sqrt(6)"
    show Neg1 = "-1"
    show One = "1"

data Number = Ele Prim
    | Mul Number Number

-- how to print a Number
instance Show Number where
    show (Ele p) = show p
    show (Mul a b) = show a ++ " * " ++ show b

-- simplify
simp :: Number -> Number
simp a = hsimp False (bounce (flatten a))

-- parity of negatives
hsimp :: Bool -> Number -> Number
-- remove ones
hsimp parity (Mul (Ele One) a) = hsimp parity a
hsimp parity (Mul a (Ele One)) = hsimp parity a
-- bookkeep negatives
hsimp parity (Mul (Ele Neg1) a) = hsimp (not parity) a
hsimp parity (Mul a (Ele Neg1)) = hsimp (not parity) a
hsimp parity (Mul (Ele a) b) = Mul (Ele a) (hsimp parity b)
hsimp parity (Mul a (Ele b)) = Mul (Ele b) (hsimp parity a)
hsimp False x = x
hsimp True (Ele Neg1) = (Ele One)
hsimp True x = (Mul x (Ele Neg1))

-- deflate tree into list
flatten :: Number -> [Number]
flatten (Mul a b) = (flatten a) ++ (flatten b)
flatten x = [x]

-- inflate list into tree
bounce :: [Number] -> Number
bounce [(Ele x)] = (Ele x)
bounce (x:xs) = Mul x (bounce xs)

sigma :: Number -> Number
sigma (Mul a b) = simp (Mul (sigma a) (sigma b))
sigma (Ele x) = case x of
    Alpha -> Mul (Ele Neg1) (Ele Beta)
    Root6 -> Mul (Ele Neg1) (Ele Root6)
    Beta -> Ele Alpha
    Neg1 -> Ele Neg1
    One -> Ele One


tau :: Number -> Number
tau (Mul a b) = simp (Mul (tau a) (tau b))
tau (Ele x) = case x of
    Alpha -> Ele Alpha
    Neg1 -> Ele Neg1
    One -> Ele One
    Beta -> Mul (Ele Neg1) (Ele Beta)
    Root6 -> Mul (Ele Neg1) (Ele Root6)

-- for use in commandline
s :: Number -> Number
s a = sigma a

t :: Number -> Number
t a = tau a

s2 :: Number -> Number
s2 a = sigma (sigma a)

s3 :: Number -> Number
s3 a = sigma (sigma (sigma a))

st :: Number -> Number
st a = sigma (tau a)

s2t :: Number -> Number
s2t a = s2 (t a)

s3t :: Number -> Number
s3t a = s3 (t a)

a = Ele Alpha
a2 = Mul a a
a3 = Mul a2 a
b = Ele Beta
r = Ele Root6
n = Ele Neg1
o = Ele One
