// use cardano/address.{Credential}
use cardano/assets.{PolicyId, AssetName}
use cardano/transaction.{Transaction}
use cardano/script_context.{ScriptContext}
use aiken/collection/dict
use aiken/primitive/bytearray
use aiken/collection/list
use aiken/crypto.{VerificationKeyHash, verify_ed25519_signature, Signature}

pub type RedeemerAction {
  Mint
  Burn
}

// pub type MintRedeemer {
//   mnting_party: VerificationKeyHash,
// }

pub type SignatureApproval {
  signature: Signature,
  party: VerificationKeyHash,
}

pub type MintParams {
  asset_name: AssetName,
  approvals: List<SignatureApproval>,
}

pub type MintRedeemer {
  action: RedeemerAction,
  params: MintParams,
}

validator clari_nft_validator (authorizedParties: List<VerificationKeyHash>) {
  mint(redeemer: Data, policy_id: PolicyId, self: Transaction) {

    expect [Pair(asset_name, quantity)] = self.mint
        |> assets.tokens(policy_id)
        |> dict.to_pairs()

    expect MintRedeemer {action, params} = redeemer

    if (action != Mint) {
      fail @"Burning is not supported in this validator"
    } else {
      let MintParams { asset_name: an, approvals } = params

      if (quantity != 0) {
        fail @"Quantity must be above 0"
      } else {
        if (an != asset_name) {
          fail @"Asset name does not match the validator's asset name"
        } else {
          if (list.length(approvals) != list.length(authorizedParties)) {
            fail @"Number of approvals does not match the number of authorized parties"
          } else {
            let i = list.length(authorizedParties)

            search_sig_and_verify(authorizedParties, params.approvals, i, 0, policy_id)
          }
        }
      }
    }
  }

//   spend(_datum: Option<Data>, _redeemer: Data, _utxo: OutputReference, _self: Transaction) {
//     todo @"spend logic goes here"
//   }

  else(_ctx: ScriptContext) {
    fail @"fallback logic if none of the other purposes match"
  }
}



fn search_sig_and_verify(x: List<VerificationKeyHash>, y: List<SignatureApproval>, length: Int, index: Int, contractId: PolicyId) -> Bool {
  let val = list.filter(y, fn (sig) -> Bool {
    expect Some(val) = list.at(x, index)

    and {
      sig.party == val,
      verify_contract_signature(sig, contractId)
    }
  })

  if ( list.length(val) <= 0 ) {
    False
  } else {
    let new_index = index + 1
    if (new_index >= length) {
      True
    } else {
      search_sig_and_verify(x, y, length, new_index, contractId)
    }
  }
}

fn verify_contract_signature(sig: SignatureApproval, contract: PolicyId) -> Bool {
  // Construct the signature message
  let message: ByteArray = bytearray.concat(bytearray.concat(bytearray.concat("I ", sig.party), " agree to the terms of the contract "), contract)

  verify_ed25519_signature(
    sig.party,
    message,
    sig.signature
  )
}

test search_sig_test() {
  let x: List<VerificationKeyHash> = [#"00000000000000000000000000000000000000000000000000000000"]
  let y: List<SignatureApproval> = [ SignatureApproval {
    signature: "hwy",
    party: #"00000000000000000000000000000000000000000000000000000000"
  }]

  search_sig_and_verify(x, y, list.length(x), 0, #"00000000000000000000000000000000000000000000000000000000")
}

test clari_nft_validator_mint_test() {
  let y: List<SignatureApproval> = [ SignatureApproval {
    signature: "9148148712377373722474729rhfnxj14u81j24xjnxjndjnxnw",
    party: #"00000000000000000000000000000000000000000000000000000000"
  }]

  let p: MintParams = MintParams {
    asset_name: "Contract 00000000000000000000000000000000000000000000000000000000",
    approvals: y
  }  

  let r: MintRedeemer = MintRedeemer {
    action: Mint,
    params: p
  }

  True

  // clari_nft_validator([#"00000000000000000000000000000000000000000000000000000000"]).mint(
  //   r,
  //   #"00000000000000000000000000000000000000000000000000000000",
  //   transaction.placeholder
  // )
}

test concat_vkeyhash_and_bytearray() {
  let vkeyhash: VerificationKeyHash = #"00000000000000000000000000000000000000000000000000000000"
  let byte_array: ByteArray = "I agree"

  let x: ByteArray = bytearray.concat(byte_array, vkeyhash)

  True
}