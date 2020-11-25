package com.example.CourseKeep.activities

import android.content.Intent
import android.os.Bundle
import android.widget.*
import com.google.android.material.floatingactionbutton.FloatingActionButton
import com.google.android.material.snackbar.Snackbar
import androidx.appcompat.app.AppCompatActivity
import com.example.CourseKeep.models.ClassModel
import com.example.myapplication.MainActivity
import com.example.myapplication.R
import io.realm.Realm
import java.lang.Exception

class AddClassActivity : AppCompatActivity() {

    lateinit var addButton: Button
    lateinit var className: EditText
    lateinit var classCode: EditText
    lateinit var dropdown: Spinner
    lateinit var realm: Realm

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_add_class)
        setSupportActionBar(findViewById(R.id.toolbar))

        realm = Realm.getDefaultInstance()
        addButton = findViewById(R.id.confirmClass)
        className = findViewById(R.id.classNameText)
        classCode = findViewById(R.id.classCodeText)
        findViewById<FloatingActionButton>(R.id.fab).setOnClickListener { view ->
            Snackbar.make(view, "Replace with your own action", Snackbar.LENGTH_LONG)
                .setAction("Action", null).show()
        }

        dropdown = findViewById(R.id.spinner)
        var items: List<String> = listOf("Online" , "Face to Face")
        var adapter: ArrayAdapter<String> = ArrayAdapter(this, android.R.layout.simple_spinner_dropdown_item, items)
        dropdown.adapter = adapter

        addButton.setOnClickListener {
            var classNameText = className.text
            var classCodeText = classCode.text
            var classType = dropdown.selectedItem
            println("Class name is: $classNameText")
            println("Class code is: $classCodeText")
            println("Class type is: $classType")
            sendToDB()
        }
    }

    fun sendToDB(){
        try {
            realm.beginTransaction()

            val currentID: Number? = realm.where(ClassModel::class.java).max("id")
            val nextID: Int
            nextID = if (currentID == null){
                1
            }else{
                currentID.toInt() + 1
            }

            val course = ClassModel()
            course.className = className.text.toString()
            course.classCode = classCode.text.toString()
            course.deliveryMethod = dropdown.selectedItem.toString()
            course.id = nextID

            realm.copyToRealmOrUpdate(course)

            realm.commitTransaction()

            Toast.makeText(this, "Class Added Successfully", Toast.LENGTH_SHORT).show()
            var intent: Intent = Intent(this , MainActivity::class.java)
            intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
            startActivity(intent)
            finish()

        } catch (e: Exception){
            Toast.makeText(this, "Failed: $e", Toast.LENGTH_SHORT).show()
        }
    }
}