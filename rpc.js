.pragma library
.import "accs.js" as Accs


function _rpc(args, cb){
    var host = "localhost";
    var port = "17076";
    var url = "http://" + host + ":" + port;
    var method="POST"

    var xhr = new XMLHttpRequest();
    xhr.open(method, url, false);
    xhr.send(JSON.stringify(args));

    var rsp = xhr.responseText;
    var res = JSON.parse(rsp);
    return res;
}

function account_history(account) {
    var args = {
        action: "account_history",
        count: "-1",
        account: account
    }

    var res = _rpc(args);
    res = res.history;
    for(var i in res) {
        res[i].binding = true;
        res[i].date = "date";
    }
    return res;
}

function send(account, amount) {
    var args = {
        action: "send",
        "wallet": Accs.a_W,
        account: account,
        amount: amount,
    }

    var res = _rpc(args);
}

function walletAccounts(wallet) {
    var args = {
        action: "wallet_balances",
        wallet: wallet
    }
    var rsp = _rpc(args);
    var res = [];
    for(var a in rsp.balances) {
        var o = rsp.balances[a];
        o.account = a;
        o.name = a;
        res.push(o);
    }
    return res;
}
