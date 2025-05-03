import tkinter as tk
from tkinter import filedialog, messagebox

hash_map_r = {
    "ADD": "000010",
    "SUB": "000110",
    "OR":  "000001",
    "AND": "000000",
    "SLT": "000111" 
}

hash_map_function_field = {
    "ADD": "100000",
    "SUB": "100010",
    "OR":  "100101",
    "AND": "100100",
    "SLT": "101010" 
}

hash_map_i = {
    "SW": "101011",
    "LW": "100011",
    "ADDI": "001000",
    "ANDI": "001100",
    "ORI": "001101",
    "SLTI": "001010",
    "SUBI": "000000"
}

archivo_seleccionado = None

def procesar_archivo():
    global archivo_seleccionado

    if archivo_seleccionado is None:
        messagebox.showerror("Error", "No se ha seleccionado ningún archivo.")
        return
    try:
        with open(archivo_seleccionado, "r") as archivo_entrada:
            lineas = archivo_entrada.readlines()
    except FileNotFoundError:
        messagebox.showerror("Error", "No se encontró el archivo especificado")
        return

    salidaBytes = ""
    opCode = ""
    for linea in lineas:
        salida = ""
        flag = ""
        conteo = 0
        instruccion = linea.split(" ") 
        for palabra in instruccion:   
            palabra = palabra.replace("\n", "") #Quitar salto de línea de NOP 
            if palabra in hash_map_r:
                salida += hash_map_r[palabra]
                opCode = palabra
                flag = "r"
            elif palabra in hash_map_i: 
                salida += hash_map_i[palabra]
                flag = "i"
            elif palabra == "J":
                salida += "000010" #Jump
                flag = "j"
            elif palabra == "NOP":
                salida += format(0, '032b')
                break
            else: #Números/direcciones
                palabra = palabra.replace("$", "").replace("#", "") #eliminar # y $
                if  conteo==3 and flag=="i":
                    if int(palabra, 10) < 0:
                        aux = int(palabra, 10)*-1
                        palabra = format(int(palabra, 10)*-1, '016b')
                        invertida = ""
                        for c in palabra:
                            if c== '0':
                                invertida += '1'
                            else:
                                invertida += '0'
                        palabra = format(int(invertida, 2)+1, 'b')
                        salida += palabra 
                    else:
                        salida += format(int(palabra, 10), '016b')
                else:
                    salida += format(int(palabra, 10), '05b')
            conteo += 1
            
        if flag == "r":
            salida += format(0, '05b') #5 ceros, los no usados
            salida += hash_map_function_field[opCode]
        if flag == "j":
            salida += format(int(palabra), '026b')
        if flag == "j":
            if int(palabra, 10) < 0:
                aux = int(palabra, 10)*-1
                palabra = format(int(palabra, 10)*-1, '026b')
                invertida = ""
                for c in palabra:
                    if c== '0':
                        invertida += '1'
                    else:
                        invertida += '0'
                palabra = format(int(invertida, 2)+1, 'b')
                salida += palabra 
            else:
                salida += format(int(palabra, 10), '026b')
        
        i = -1
        parteA = ""
        parteB = ""
        parteC = ""
        parteD = ""
        if flag == "r" or flag == "i":
            for c in salida:
                i += 1
                if i < 6:
                    parteA += c
                elif i>=6 and i<11:
                    parteB += c
                elif (i>=11 and i<21 and flag == "r"):
                    parteC += c
                elif (i>=11 and i<16 and flag == "i"):
                    parteC += c
                else:
                    parteD += c
                        
            salida = parteA + parteC + parteB + parteD

        i = -1
        for c in salida:
            i += 1
            if i == 8:
                salidaBytes += '\n'
                i = 0
            salidaBytes += c
        salidaBytes += '\n'
        
    # Guardar el resultado en instrucciones.txt
    with open("instrucciones_8b.txt", "w") as archivo_salida:
        archivo_salida.write(salidaBytes)

    # Mostrar mensaje de éxito y actualizar la interfaz
    resultado_label.config(text="Instrucciones convertidas correctamente y guardadas en 'instrucciones.txt'")

def abrir_archivo():
    global archivo_seleccionado

    # Obtener el path del archivo .asm usando un cuadro de diálogo
    archivo_seleccionado = filedialog.askopenfilename(filetypes=[("Archivos ASM", "*.asm")])
    if archivo_seleccionado:        
        mostrar_contenido(archivo_seleccionado)
        boton_convertir.config(state="normal")  # Habilitar el botón de conversión

def mostrar_contenido(path_archivo):
    try:
        with open(path_archivo, "r") as archivo_entrada:
            contenido = archivo_entrada.read()
        # Mostrar el contenido del archivo en el Text widget
        area_texto.delete(1.0, tk.END)  # Limpiar antes de mostrar
        area_texto.insert(tk.END, contenido)
    except FileNotFoundError:
        messagebox.showerror("Error", "No se pudo abrir el archivo")

# Crear la ventana de la GUI
ventana = tk.Tk()
ventana.title("Procesador de Instrucciones")
ventana.geometry("500x400")  # Tamaño de la ventana

# Estilo
ventana.config(bg="#f0f0f0")

# Título de la aplicación
titulo = tk.Label(ventana, text="Convertidor de Instrucciones ASM a binario", font=("Arial", 14), bg="#f0f0f0")
titulo.pack(pady=20)

# Botón para abrir el archivo y cargarlo
boton_abrir = tk.Button(ventana, text="Abrir archivo .asm", command=abrir_archivo, bg="#4CAF50", fg="white", font=("Arial", 12))
boton_abrir.pack(pady=10)

# Área de texto para mostrar el contenido del archivo
area_texto = tk.Text(ventana, height=10, width=50, font=("Arial", 12))
area_texto.pack(pady=10)

# Botón para convertir las instrucciones, inicialmente deshabilitado
boton_convertir = tk.Button(ventana, text="Convertir Instrucciones", command=procesar_archivo, bg="#2196F3", fg="white", font=("Arial", 12), state="disabled")
boton_convertir.pack(pady=10)

# Etiqueta para mostrar el estado del proceso
resultado_label = tk.Label(ventana, text="", bg="#f0f0f0", font=("Arial", 12))
resultado_label.pack(pady=10)

# Ejecutar la ventana principal
ventana.mainloop()
