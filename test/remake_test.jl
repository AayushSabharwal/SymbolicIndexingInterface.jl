using SymbolicIndexingInterface
using StaticArrays

sys = SymbolCache([:x, :y, :z], [:a, :b, :c], :t)

for (buf, newbuf, idxs, vals) in [
    # standard operation
    ([1.0, 2.0, 3.0], [2.0, 3.0, 4.0], [:x, :y, :z], [2.0, 3.0, 4.0]),
    # buffer type "demotion"
    ([1.0, 2.0, 3.0], [2, 2, 3], [:x], [2]),
    # buffer type promotion
    ([1, 2, 3], [2.0, 2.0, 3.0], [:x], [2.0]),
    # value type promotion
    ([1, 2, 3], [2.0, 3.0, 4.0], [:x, :y, :z], Real[2, 3.0, 4.0]),
    # standard operation
    ([1.0, 2.0, 3.0], [2.0, 3.0, 4.0], [:a, :b, :c], [2.0, 3.0, 4.0]),
    # buffer type "demotion"
    ([1.0, 2.0, 3.0], [2, 2, 3], [:a], [2]),
    # buffer type promotion
    ([1, 2, 3], [2.0, 2.0, 3.0], [:a], [2.0]),
    # value type promotion
    ([1, 2, 3], [2, 3.0, 4.0], [:a, :b, :c], Real[2, 3.0, 4.0])
]
    for arrType in [Vector, SVector{3}, MVector{3}, SizedVector{3}]
        buf = arrType(buf)
        newbuf = arrType(newbuf)
        _newbuf = remake_buffer(sys, buf, idxs, vals)

        @test _newbuf != buf # should not alias
        @test newbuf == _newbuf # test values
        @test typeof(newbuf) == typeof(_newbuf) # ensure appropriate type
        @test_deprecated remake_buffer(sys, buf, Dict(idxs .=> vals))
    end
end

for (buf, newbuf, idxs, vals) in [
    # standard operation
    ((1.0, 2.0, 3.0), (2.0, 3.0, 4.0), [:a, :b, :c], [2.0, 3.0, 4.0]),
    # buffer type "demotion"
    ((1.0, 2.0, 3.0), (2, 3, 4), [:a, :b, :c], [2, 3, 4]),
    # buffer type promotion
    ((1, 2, 3), (2.0, 3.0, 4.0), [:a, :b, :c], [2.0, 3.0, 4.0]),
    # value type promotion
    ((1, 2, 3), (2, 3.0, 4.0), [:a, :b, :c], Real[2, 3.0, 4.0]),
    # standard operation
    ((1.0, 2.0, 3.0), (2.0, 3.0, 4.0), [:x, :y, :z], [2.0, 3.0, 4.0]),
    # buffer type "demotion"
    ((1.0, 2.0, 3.0), (2, 3, 4), [:x, :y, :z], [2, 3, 4]),
    # buffer type promotion
    ((1, 2, 3), (2.0, 3.0, 4.0), [:x, :y, :z], [2.0, 3.0, 4.0]),
    # value type promotion
    ((1, 2, 3), (2, 3.0, 4.0), [:x, :y, :z], Real[2, 3.0, 4.0])
]
    _newbuf = remake_buffer(sys, buf, idxs, vals)
    @test newbuf == _newbuf # test values
    @test typeof(newbuf) == typeof(_newbuf) # ensure appropriate type
    @test_deprecated remake_buffer(sys, buf, Dict(idxs .=> vals))
end
