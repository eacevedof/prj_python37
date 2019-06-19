# Tutorial de selenium by Pablo Sofer

#### [Tutorial Seleninum Capítulo 1: "Hola Mundo"](https://www.youtube.com/watch?v=N-rdcdWmYck&list=PLjM3-neCG6qx4RFeq2X-TpWS_tJTk1qZP&index=2)

- [Driver](https://chromedriver.storage.googleapis.com/index.html?path=75.0.3770.90/)
- **chromedriver.exe**
- [Site demo](http://newtours.demoaut.com/)

#### [Cap 2 - Dropdown](https://youtu.be/lB9pypRYev4?list=PLjM3-neCG6qx4RFeq2X-TpWS_tJTk1qZP&t=88)
- dropdown.py

#### [Cap 3 - Localizando elementos](https://youtu.be/DXSgxIgoZ2E?list=PLjM3-neCG6qx4RFeq2X-TpWS_tJTk1qZP)
- distintos métodos para navegar por el DOM

#### [Cap 4 - Localizando por Id y Name](https://youtu.be/YLYNThOaP9w?list=PLjM3-neCG6qx4RFeq2X-TpWS_tJTk1qZP)
- google.py

#### [Cap 5 - Utilizando FirePath](https://youtu.be/H2okGWszwo0?list=PLjM3-neCG6qx4RFeq2X-TpWS_tJTk1qZP)
- firepath.py
- instalar firepath addon en el navegador de modo que nos ayude a decifrar el xpath de un nodo
#### [Cap 6 - Asserts](https://youtu.be/sZqxadW_E6o?list=PLjM3-neCG6qx4RFeq2X-TpWS_tJTk1qZP)
- asserts.py
- vamos a usar el assert de selenium pero despues usaremos mejores herramientas 
```py
assert link_registration_form.text == "registration form"
assert link_registration_form.tag_name == "p

File "asserts.py", line 20, in <module>
    assert link_registration_form.text == "registration form xxxxxxxxxxx"
AssertionError
```
#### [Cap 7 - Unit test](https://youtu.be/k3eq4RnVCDQ?list=PLjM3-neCG6qx4RFeq2X-TpWS_tJTk1qZP)
- newtourtest.py
- Ya ha pasado los test, es necesario llamar a: **def setUp(self):**

#### [Cap 8 - Más Asserts](https://youtu.be/BXEDlUobvV8?list=PLjM3-neCG6qx4RFeq2X-TpWS_tJTk1qZP)
- newtourtest.py
- test_dropdown
- assertFalse en lugar de assertEquals
```py
newtourtest.py:35: DeprecationWarning: Please use assertEqual instead.
  self.assertEquals(link_registration_form.text,"registration form")
```
#### [Cap 9 - Page Objects parte 1](https://youtu.be/cHWt_gFkU2M?list=PLjM3-neCG6qx4RFeq2X-TpWS_tJTk1qZP)
- newtourtest.py
- pasando lineas repetidas al setup
- pageindex.py
