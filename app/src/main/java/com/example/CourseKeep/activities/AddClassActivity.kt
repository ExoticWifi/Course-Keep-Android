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
import kotlin.concurrent.fixedRateTimer

class AddClassActivity : AppCompatActivity() {

    lateinit var addButton: Button
    lateinit var incHours: Button
    lateinit var decHours: Button
    lateinit var className: EditText
    lateinit var classCode: EditText
    lateinit var deliveryMethod: EditText
    lateinit var realm: Realm
    lateinit var hoursText: TextView
    lateinit var sectionNumber: EditText
    lateinit var sunBox: CheckBox
    lateinit var monBox: CheckBox
    lateinit var tueBox: CheckBox
    lateinit var wedBox: CheckBox
    lateinit var thurBox: CheckBox
    lateinit var friBox: CheckBox
    lateinit var satBox: CheckBox
    var message = StringBuilder()
    var daysList = ArrayList<String> ()
    var hoursInt: Int = 0
    lateinit var days: List<CheckBox>
    var hoursMessage = "Number of hours: $hoursInt"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_add_class)

        realm = Realm.getDefaultInstance()
        addButton = findViewById(R.id.confirmClass)
        hoursText = findViewById(R.id.creditHoursText)
        hoursText.text = hoursMessage
        incHours = findViewById(R.id.plusButton)
        decHours = findViewById(R.id.minusButton)
        className = findViewById(R.id.classNameText)
        classCode = findViewById(R.id.classCodeText)
        deliveryMethod = findViewById(R.id.location)
        sectionNumber = findViewById(R.id.classSectionText)
        sunBox = findViewById(R.id.sunday)
        monBox = findViewById(R.id.monday)
        tueBox = findViewById(R.id.tuesday)
        wedBox = findViewById(R.id.wednesday)
        thurBox = findViewById(R.id.thursday)
        friBox = findViewById(R.id.friday)
        satBox = findViewById(R.id.saturday)



        addButton.setOnClickListener {
            var classNameText = className.text
            var classCodeText = classCode.text
            var classType = deliveryMethod.text
            println("Class name is: $classNameText")
            println("Class code is: $classCodeText")
            println("Class type is: $classType")
            sendToDB()
        }

        incHours.setOnClickListener {
            hoursInt += 1
            hoursText.text = "Number of hours: $hoursInt"
        }

        decHours.setOnClickListener {
            hoursInt -= 1
            hoursText.text = "Number of hours: $hoursInt"
        }
    }

    fun sendToDB(){
        try {
            if (sunBox.isChecked) {
                daysList.add("Sunday")
            }
            if (monBox.isChecked) {
                daysList.add("Monday")
            }
            if (tueBox.isChecked) {
                daysList.add("Tuesday")
            }
            if (wedBox.isChecked) {
                daysList.add("Wednesday")
            }
            if (thurBox.isChecked) {
                daysList.add("Thursday")
            }
            if (friBox.isChecked) {
                daysList.add("Friday")
            }
            if (satBox.isChecked) {
                daysList.add("Saturday")
            }


            for (day in daysList){
                message.append(day)
                if (day != daysList[daysList.lastIndex]){
                    message.append(", ")
                }
            }
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
            course.deliveryMethod = deliveryMethod.text.toString()
            course.section = sectionNumber.toString()
            course.id = nextID
            course.hours = hoursInt
            course.mon = monBox.isChecked
            course.sun = sunBox.isChecked
            course.tue = tueBox.isChecked
            course.wed = wedBox.isChecked
            course.thu = thurBox.isChecked
            course.fri = friBox.isChecked
            course.sat = satBox.isChecked
            course.days = message.toString()

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