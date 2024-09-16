/// UNFINISHED code for `OrderedHashMap`.

import HashMap "mo:base/HashMap";
import Hash "mo:base/Hash";
import Buffer "mo:base/Buffer";

module {
    public class OrderedHashMap<K, V>(
        initCapacity : Nat,
        keyEq : (K, K) -> Bool,
        keyHash : K -> Hash.Hash
    ) {
        let m = HashMap.HashMap<K, V>(initCapacity, keyEq, keyHash);
        let list = Buffer.Buffer<K>(initCapacity);

        public func add(key: K, value: V) {
            m.put(key, value);
            list.add(key);
        };
    };
}