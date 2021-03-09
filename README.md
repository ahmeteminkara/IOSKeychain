# IOSKeychain

A new flutter plugin project.

## Getting Started
```yaml
dependencies:
    ios_keychain:
        git:
            url: git://github.com/ahmeteminkara/ios_keychain.git
```

```dart
import 'package:ios_keychain/ios_keychain.dart';
```

## Using
```ruby
String value = await IOSKeychain.read(_key);
bool status = await IOSKeychain.write(_key, "DATA");
bool status = await IOSKeychain.update(_key, "NEW DATA");
bool status = await IOSKeychain.remove(_key);
```