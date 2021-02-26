import {
  Alert,
  Button,
  NativeModules,
  StyleSheet,
  Text,
  TextInput,
  View
} from 'react-native';
import React, { useState } from 'react';

const { WidgetBridge } = NativeModules
const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center' 
  },
  title: {
    fontSize: 20
  },
  input: {
    borderBottomWidth: 1,
    width: '80%',
    height: 30
  },
  button: {
    width: 50,
    height: 100,
    fontSize: 30,
  }
});
const App = () => {
  const [text, setText] = useState('');

  const submit = async () => {
    const success = await WidgetBridge.setValue(text)
    if (success) {
      
      const result =await WidgetBridge.reloadWidget("Test")
      console.log(result)
    }
    
    setText('')
    Alert.alert('已送出')
  }

  return (
    <View style={styles.container}>
      <View style={{ marginBottom: 30}}>
        <Text style={styles.title}>請輸入你要在 widget 上顯示的文字</Text>
      </View>
      <TextInput style={styles.input} onChangeText={setText} value={text} placeholder="輸入文字" />
      <Button title='送出' onPress={submit} />
    </View> 
  );
};



export default App;
