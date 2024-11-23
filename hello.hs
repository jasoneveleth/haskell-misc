-- main :: IO ()
-- main =
--     putStrLn "Hello, world!" >>
--     putStrLn "What is your name, user?" >>
--     getLine >>= (\name ->
--         putStrLn ("Nice to meet you, " ++ name ++ "!"))

main :: IO ()
main = putStrLn "Hello, world!" >>
       putStrLn "What is your name, user?" >>
       getLine >>= (\x -> putStrLn ("Nice to meet you, " ++ x ++ "!"))
