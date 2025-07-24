// use cardano/address.{Credential}
use cardano/assets.{PolicyId, AssetName}
use cardano/transaction.{Transaction}
use cardano/script_context.{ScriptContext}
use aiken/collection/dict
use aiken/collection/list
use aiken/crypto.{VerificationKeyHash}

pub type RedeemerAction {
  Mint
  Burn
}

// pub type MintRedeemer {
//   mnting_party: VerificationKeyHash,
// }

pub type SignatureApproval {
  signature: ByteArray,
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
        fail @"Quantity must be one"
      } else {
        if (an != asset_name) {
          fail @"Asset name does not match the validator's asset name"
        } else {
          if (list.length(approvals) != list.length(authorizedParties)) {
            fail @"Number of approvals does not match the number of authorized parties"
          } else {
            let i = list.length(authorizedParties)

            search_sig(authorizedParties, params.approvals, i, 0)
            // for (approval in approvals) {
            //   if (!list.contains(authorizedParties, approval.party)) {
            //     fail @"Approval party is not authorized"
            //   } else {
            //     True
            //   }
            // }
          }
        }
      }
    }
  }

//   spend(_datum: Option<Data>, _redeemer: Data, _utxo: OutputReference, _self: Transaction) {
//     todo @"spend logic goes here"
//   }

//   withdraw(_redeemer: Data, _account: Credential, _self: Transaction) {
//     todo @"withdraw logic goes here"
//   }

//   publish(_redeemer: Data, _certificate: Certificate, _self: Transaction) {
//     todo @"publish logic goes here"
//   }

//   vote(_redeemer: Data, _voter: Voter, _self: Transaction) {
//     todo @"vote logic goes here"
//   }

//   propose(_redeemer: Data, _proposal: ProposalProcedure, _self: Transaction) {
//     todo @"propose logic goes here"
//   }

  // // If needs be, remove any of unneeded handlers above, and use:
  //
  else(_ctx: ScriptContext) {
    fail @"fallback logic if none of the other purposes match"
  }
  //
  // // You will also need an additional import:
  // //
  // // use cardano/script_context.{ScriptContext}
}

// pub type SigTest {
//   signature: ByteArray,
//   party: String,
// }


fn search_sig(x: List<VerificationKeyHash>, y: List<SignatureApproval>, length: Int, index: Int) -> Bool {
  let val = list.filter(y, fn (sig) -> Bool {
    expect Some(val) = list.at(x, index)

    sig.party == val
  })

  if ( list.length(val) <= 0 ) {
    False
  } else {
    let new_index = index + 1
    if (new_index >= length) {
      True
    } else {
      search_sig(x, y, length, new_index)
    }
  }
}

test search_sig_test() {
  let x: List<VerificationKeyHash> = [#"00000000000000000000000000000000000000000000000000000000"]
  let y: List<SignatureApproval> = [ SignatureApproval {
    signature: "hwy",
    party: #"00000000000000000000000000000000000000000000000000000000"
  }]

  search_sig(x, y, list.length(x), 0)
}

test clari_nft_validator_mint_test() {
  let y: List<SignatureApproval> = [ SignatureApproval {
    signature: "hwy",
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

  clari_nft_validator([#"00000000000000000000000000000000000000000000000000000000"]).mint(
    r,
    #"00000000000000000000000000000000000000000000000000000000",
    transaction.placeholder
  )
  // let params = MintParams {
  //     asset_name: "Contract 00000000000000000000000000000000000000000000000000000000"
  //     approvals:  [ SignatureApproval {
  //       signature: "hwy",
  //       party: #"00000000000000000000000000000000000000000000000000000000"
  //     }]
  //   }
  // let redeemer = MintRedeemer {
  //   // action: RedeemerAction.Mint,
  //   params: params
  // }

  // True
}