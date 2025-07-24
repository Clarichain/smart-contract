test test_learn() {
    // Data types

    let boolean_var: Bool = True // Values either true or false

    // Operators on boolean data type aiken
    // Equality operator ( == )
    // Logical conjunction ie AND ( && )
    // Logical disjunction ie OR ( || )
    // Logical negation ie NOT ( ! )
    // Trace if ( ? ) // Outputs or traces a value if theres an error

    // The "and" and "or" keywords
    // Eg for an boolean evaluation of (True && True && False ) || (True && False)

    let and_or_keywords_output = or {
        and {
            True,
            True,
            False,
        },
        and {
            True,
            False
        }
    }


    // Int
    let integer_var: Int = 10 // Rational numbers
    let integer_var_with_seperator: Int = 1_000_000_000

    // Aiken also supports integers in other number bases using the base prefix

    // Faulty base handlers
    // let integer_2_base_10: Int = "0b00001111"
    // let integer_12_base_8: Int = 0o14
    // let integer_15_base_16: Int = 0xF 

    // trace 0b00000010 == 2
    // // trace integer_12_base_8 == 12
    // // trace integer_15_base_16 == 15

    //Operators on integer data type aiken
    // Equality ( == )
    // Greater than ( > )
    // Lesser than ( < )
    // Lesser than or equal to ( <= )
    // Greater than or equal to ( >= )


    // ByteArray - Basically an array of bytes, Has three different notations
    let byte_array_variable_as_an_array_of_bytes = #[10, 255]
    let byte_array_as_string = "Hello"
    let byte_array_as_hex_codes = #"666362fa13"


    // List Data type - All data types in the array should be the same
    let list_variable = [1, 4, 56, 28, 42]
    
    // Spread operation ie ..
    let spread_variable = [1, ..[2, 4]]


    // Tuples Data type - A collection which supports multiple data types
    (10, "hello");


    True
}