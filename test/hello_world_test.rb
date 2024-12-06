```ruby
require 'minitest/autorun'
require_relative '../src/hello_world'

class HelloWorldTest < Minitest::Test
  def test_say_hello
    hello_world = HelloWorld.new
    assert_equal "Hello, World!", hello_world.say_hello
  end
end
```

El archivo `hello_world_test.rb` contiene los casos de prueba para la clase `HelloWorld`. Podemos agregar más casos de prueba aquí para cubrir diferentes escenarios y asegurarnos de que la funcionalidad de la clase funcione como se espera.