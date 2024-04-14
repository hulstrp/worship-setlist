--[[
    In this function we can give additional value to deposits,
    withdrawals and transfers, therefore when one is executed,
    it will execute these functions.

    Please do not edit this if you are not a developer
    or do not have much programming experience.
]]

function TransactionEvent(owner, other, amount, type)
    if type ~= 'deposit' then
        print('Withdraw test', owner, other, amount, type)
        -- exports['snipe-banking']:CreatePersonalTransactions(owner, tonumber(amount), 'Loan Payment for Loan ID:' .. ' ' .. other, 'withdraw')
    else
        print('Deposit test', other, owner, amount, type)
        -- exports['snipe-banking']:CreatePersonalTransactions(other, tonumber(amount), 'Loan Approved for Loan ID:' .. ' ' .. owner, 'deposit')
    end
end
