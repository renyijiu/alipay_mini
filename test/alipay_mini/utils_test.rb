require "test_helper"

class AlipayMini::UtilsTest < Minitest::Test

  def test_stringify_keys
    hash_one = {'a' => 1, :b => 2}
    hash_two = {'a' => 1, :b => { 'c' => 2, :d => 3 }}

    assert_equal({'a' => 1, 'b' => 2}, AlipayMini::Utils.stringify_keys(hash_one))
    assert_equal({'a' => 1, 'b' => { 'c' => 2, 'd' => 3 }}, AlipayMini::Utils.stringify_keys(hash_two))
  end

  def test_params_to_string
    params = {
        hello: 'world',
        nick_name: 'renyijiu'
    }
    string = "hello=world&nick_name=renyijiu"

    assert_equal string, AlipayMini::Utils.params_to_string(params)
  end

  def test_compact_hash
    hash = {
        1 => nil,
        2 => 'hello',
        3 => 'world',
    }

    res = AlipayMini::Utils.deep_compact(hash)
    assert_equal 2, res.keys.count
  end

  def test_deep_compact_hash
    hash = {
        1 => 'hello',
        2 => {
            3 => nil,
            5 => 'world',
            6 => {
                7 => nil,
                8 => 'world'
            }
        }
    }

    res = AlipayMini::Utils.deep_compact(hash)
    assert_equal 2, res[2].keys.count
  end
end

