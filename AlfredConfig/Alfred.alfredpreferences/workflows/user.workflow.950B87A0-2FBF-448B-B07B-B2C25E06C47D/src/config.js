'use strict';

const alfy = require('alfy');
const sample = require('lodash.sample');
const crypto = require('crypto');
function truncate(q){
    var len = q.length;
    if(len<=20) return q;
    return q.substring(0, 10) + len + q.substring(len-10, len);
}

module.exports = {
    youDaoApi: 'https://openapi.youdao.com/api',
    getParams: function () {
        var appKey = '267e5e087390ffac'; // 你的应用ID
        var key = '0KXVS6k6UMxz0YoCWbaojRfgmowNC2nD'; // 你的应用秘钥
        var salt = (new Date).getTime();
        var curtime = Math.round(new Date().getTime() / 1000);
        var str1 = appKey + truncate(alfy.input) + salt + curtime + key;
        const hash = crypto.createHash('sha256');
        hash.update(str1);

        return {
            query: {
                q: alfy.input,
                appKey,
                salt,
                from: 'zh-CHS',
                to: 'en',
                sign: hash.digest('hex'),
                signType: "v3",
                curtime,
            }
        }
    },
    filter: {
        prep: [
            'and', 'or', 'the', 'a', 'at', 'of'
        ],
        prefix: [],
        suffix: [
            'ing', 'ed', 'ly'
        ],
        verb: [
            'was'
        ]
    }
};