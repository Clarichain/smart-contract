use cardano/assets.{PolicyId}
use cardano/transaction.{Transaction, OutputReference}
use aiken/collection/list
 

validator my_script {
  mint(redeemer: Data, policy_id: PolicyId, self: Transaction) {
    todo @"validator logic goes here"
  }
}

pub type UTXO = OutputReference

validator one_shot_mint (input: UTXO) {
    mint (redeemer: Data, policy_id: PolicyId, tx: Transaction) {
        expect list.any(tx.inputs, fn (input: x) {
            input.output_reference == x
        })

        todo @"rest of the logic goes here"
    }
}

// U can call ur handlers from within aiken with this syntax {validator_name}.{handler}

// Only allowed handlers mint, spend, withdraw, publish, vote or propose. Every helper function must return Boolean values


// Tracing

fn foo(my_list: List<Option<Int>>) -> Bool {
  trace @"foo": my_list
  list.is_empty(my_list)
}