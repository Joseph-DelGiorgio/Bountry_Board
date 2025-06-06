module bountyboard_contracts::main {
    use sui::object::{Self, UID};
    use sui::tx_context::TxContext;
    use sui::transfer;

    struct Bounty has key {
        id: UID,
        description: vector<u8>,
        value: u64,
        poster: address,
        doer: address,
        is_completed: bool,
    }

    public entry fun create_bounty(
        description: vector<u8>,
        value: u64,
        ctx: &mut TxContext,
    ) {
        let bounty = Bounty {
            id: object::new(ctx),
            description,
            value,
            poster: ctx.sender(),
            doer: @0x0,
            is_completed: false,
        };
        transfer::transfer(bounty, ctx.sender());
    }

    public entry fun accept_bounty(bounty: &mut Bounty, new_doer: address) {
        assert!(bounty.doer == @0x0, 0); // Only if not yet accepted
        bounty.doer = new_doer;
    }

    public entry fun complete_bounty(bounty: &mut Bounty) {
        bounty.is_completed = true;
    }
}
