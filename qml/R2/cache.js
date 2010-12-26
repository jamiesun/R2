var cache = {}
function set(k,v){
    cache[k] = v;
}
function get(k){
    return cache[k];
}
