use aiken/collection/list

// Aiken also supports the use of constants
// For a constant, we use the const keyword and they are top-leveled, that is they can be written outside of funtions or validators

const constant_vatriable: ByteArray = "Eremie Johnson"

// custom types

// The enum like type or Multiple constructors
type Name {
    FirstName
    LastName
    MiddleName
    Suffix
    NickName
    Initials
    FullName
    Title
    Salutation
    Display
}

// Struct like, named struct, with single constructors
type Datum {
    Datum {
        signer: ByteArray,
        count: Int
    }
}

// MULTIPLE CONSTRUCTORS WITH SOME CONSTRUCTORS HAVING THEIR OWN DATA VALUE
pub type User {
  LoggedIn { username: ByteArray }  // A logged in user
  Guest // A guest user with no details
}

// Struct like, unnamed struct with single constructors
type Datum2 {
    Datum2 (ByteArray, Int)
}

type Box<inner_type> {
  Box(inner_type)
} // Generic types, this is a generic type that can take in any data format

fn use_the_box_type() {
  let a = Box(420) // type is Box<Int> 
  let b = Box("That's my ninja way!") // type is Box<ByteArray>
  
  True
}

// Destructuring syntax
fn call_datum(Datum {signer, count}) -> ByteArray {
    signer
}

fn call_datum2(Datum2 (signer, count)) -> ByteArray {
    signer
}


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
    let list_variable: List<Int> = [1, 4, 56, 28, 42]
    
    // Spread operation ie ..
    let spread_variable: List<Int>  = [1, ..list_variable]
    let spread_variable_2: List<Int> = [4, ..[2, 4]]


    // Tuples Data type - A collection which supports multiple data types
    let tuple_variable = (10, "hello")

    // accessing elements in a tuple, accessing via indexing
    trace tuple_variable.1st
    trace tuple_variable.2nd

    // Pair data type aiken
    let foo = Pair(14, "aiken")
 
    let _ = foo.1st == 14
    
    let _ = foo.2nd == "aiken"

    let _ = get_head([1, 3, 5])

    let _ = to_positive(-1)

    // Void data type

    // Data data type, kinda like the any in ts, accepts literally any type and can be serialized down to any type

    let string_variable = @"Hello, Aiken!" // String most likely used for debugging purposes since bytearray are literally strings with smaller size

    // Accessing values from a struct custom type constructor
    let user = Datum {
        signer: "Eremie Johnson",
        count: 12
    }
    
    trace user.signer // Kinda the same as rust

    // To access properties in a nameless parameter struct, we use it's index
    let data_with_datum_2 = Datum2 ("Eremie Johnson", 23)

    let Datum2 (name, ..) = data_with_datum_2

    trace name

    // Renaming destructured variables just like js syntax
    let Datum {signer: x_name, ..} = Datum {
        signer: "Eremie Johnson",
        count: 2
    }

    trace x_name

    trace get_name( Datum {
        signer: "Eremie Johnson",
        count: 2
    })

    True
}

fn get_name(user: Datum) -> ByteArray {
    when user is {
        Datum { signer, .. } ->  signer
    }
}

fn get_head(items: List<a>) -> Option<a> {
    list.at(items, 0)
}

fn to_positive(x: Int) -> Option<Int> {
    if x > 0 {
        Some(x)
    } else {
        None
    }
}

pub type AlternateMatching {
    Match1 { value: Int }
    Match2 { value: ByteArray }
    Match3 { value: Int }
}

fn use_alternate_matching(x: AlternateMatching) {
    when x is {
        Match1 { value } | Match3 { value } -> True
        Match2 { .. } -> False
    }
}

fn use_list_matching_is_empty(x: List<Int>) -> Void {
    let y: Bool = when x is {
        [] -> True
        [_] -> True
        [_, ..] -> False
    }

    trace y
}

fn nexted_pattern_match(x: Option<List<String>>) -> Void {
    let x = when x is {
        Some([head, ..]) -> Some(head)
        Some([]) -> None
        None -> None
    }

    trace x
}

fn assign_names_to_s_patterns(xs: List<List<a>>) -> List<a> {
    when xs is {
        [[_, ..] as inner_list, ..] -> inner_list
        _other -> []
    }
}

type Person {
  name: ByteArray,
  shoe_size: Int,
  age: Int,
  is_happy: Bool,
}
 
fn have_birthday(person) {
  // It's this person's birthday, so increment their age and
  // make them happy
  Person { ..person, age: person.age + 1, is_happy: True }
}

test run_other_checks() {
    use_list_matching_is_empty([1])
    nexted_pattern_match(Some([@"JScripts", @"Any other string data"]))

    True
}

