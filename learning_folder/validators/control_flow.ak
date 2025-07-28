fn piping_syntax_1(a: Int, b: Int) -> Int {
    a * b
}

fn pipe_syntax_2(a: Int) -> Int {
    a + 1
}

fn favourite_number() -> Int {
  // The type annotations says this returns an Int, but we don't need
  // to implement it yet.
//   todo // Without a reason
  todo @"Believe in the you that believes in yourself!" // With a reason
}
 
fn expect_some_value(opt: Option<a>) -> a {
  when opt is {
    Some(a) -> a
    None -> fail // We want this to fail when we encounter 'None'.
  }
}

test all_tests() {
    // Instead of
    let x = piping_syntax_1(3, 5)
    let y = pipe_syntax_2(x)

    // We can do this with the pipe syntax
    let z = piping_syntax_1(3, 5)
        |> pipe_syntax_2

    trace z == y

    // If else statement
    let some_bool = True
 
    if some_bool {
        trace @"It's true!"
    } else {
        trace @"It's not true."
    }

    // We can have nexted if or use the else if statement depending on your use case

    // Fail and todo syntax - Where we have to like hault or panic our code due to an incomplete logic or failure case respectively
    
    let _ = favourite_number() // Provides warning using the todo syntax
    let _ = expect_some_value(None) // Panics the code

    // Expect key word for not exhaustive matching eg the if let Some(x) = y else {} or let Some(x) = y {} else {}
    expect Some(value) = Some(43) // Short syntax

    // instead of
    let _ = when Some(43) is {
        Some (value) -> value
        None -> fail
    } // Long syntax

    //  Casting dat from Data to a custom Type
    // let data: Data = Some<10>
    // expect _x: Option<Int> = data

    True
}

// No loopes so we write recursive functions