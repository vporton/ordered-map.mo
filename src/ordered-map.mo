/// UNFINISHED code for `OrderedHashMap`.

import HashMap "mo:base/HashMap";
import Hash "mo:base/Hash";
import Buffer "mo:base/Buffer";
import Iter "mo:base/Iter";
import Debug "mo:base/Debug";
import Order "mo:base/Order";

module {
    public class OrderedHashMap<K, V>(
        initCapacity : Nat,
        keyEq : (K, K) -> Bool,
        keyHash : K -> Hash.Hash
    ) {
        let m = HashMap.HashMap<K, V>(initCapacity, keyEq, keyHash);
        let list = Buffer.Buffer<K>(initCapacity);

        public func size(): Nat = list.size();

        public func get(key: K): ?V = m.get(key);

        public func put(key: K, value: V) {
            m.put(key, value);
            list.add(key);
        };

        // func replace(key : K, value : V) : (oldValue : ?V)
        // func delete(key : K)
        // func remove(key : K) : (oldValue : ?V)

        public func keys(): Iter.Iter<K> = list.vals();

        public func vals(): Iter.Iter<V> {
            Iter.map<K, V>(list.vals(), func (key: K) = switch (m.get(key)) {
                case (?value) value;
                case null { Debug.trap("ordered-map: programming error") };
            });
        };

        public func entries(): Iter.Iter<(K, V)> {
            Iter.map<K, (K, V)>(list.vals(), func (key: K) = switch (m.get(key)) {
                case (?value) (key, value);
                case null { Debug.trap("ordered-map: programming error") };
            });
        };
    };

    // TODO
    // func clone<K, V>(map: OrderedHashMap<K, V>, keyEq : (K, K) -> Bool, keyHash : K -> Hash.Hash) : OrderedHashMap<K, V> = {
    // };

    func fromIter<K, V>(iter : Iter.Iter<(K, V)>, initCapacity : Nat, keyEq : (K, K) -> Bool, keyHash : K -> Hash.Hash)
        : OrderedHashMap<K, V>
    {
        let t = OrderedHashMap<K, V>(initCapacity, keyEq, keyHash);
        for ((k, v) in iter) {
            t.put(k, v);
        };
        t;
    };

    // public func map<K, V1, V2>(hashMap : HashMap<K, V1>, keyEq : (K, K) -> Bool, keyHash : K -> Hash.Hash, f : (K, V1) -> V2) : HashMap<K, V2>
    // public func mapFilter<K, V1, V2>(hashMap : HashMap<K, V1>, keyEq : (K, K) -> Bool, keyHash : K -> Hash.Hash, f : (K, V1) -> ?V2) : HashMap<K, V2>

}