package com.example.CourseKeep

import android.content.Intent
import android.graphics.Color
import android.os.Bundle
import android.view.View
import android.widget.Button
import android.widget.EditText
import android.widget.TextView
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.core.content.ContextCompat
import com.example.CourseKeep.models.ClassModel
import com.example.myapplication.MainActivity
import com.example.myapplication.R
import io.realm.Realm
import io.realm.RealmResults
import kotlinx.android.synthetic.main.activity_course_info.*

class CourseInfoActivity() : AppCompatActivity() {
    lateinit var realm: Realm
    var id = 0
    var confirmDelete: Boolean = false
    var daysList = ArrayList<String> ()
    var isEdit: Boolean = false
    lateinit var course: ClassModel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_course_info)

        realm = Realm.getDefaultInstance()

        id = intent.getIntExtra("cLass" , 1)
        course = realm.where(ClassModel::class.java)
            .equalTo("id", id)
            .findFirst()!!


        if (course != null) {
            setDefaultText()
        }

        courseNameTitle.isEnabled = false
        codeValue.isEnabled = false
        creditsValue.isEnabled = false
        timeValue.isEnabled = false
        locationValue.isEnabled = false
        daysValue.isEnabled = false

        deletebutton.setOnClickListener {
            if (confirmDelete != true) {
                if (isEdit == true) {
                    if (course != null) {
                        realm.beginTransaction()
                        course.className = courseNameTitle.text.toString()
                        course.classCode = codeValue.text.toString()
                        course.hours = creditsValue.text.toString().toInt()
                        course.deliveryMethod = locationValue.text.toString()
                        course.days = daysValue.text.toString()
                        realm.commitTransaction()
                        isEdit = false

                        setFieldState(isEdit)
                        changeBoxLook(isEdit)

                        editButton.text = "Edit"
                        deletebutton.background = getDrawable(R.drawable.delete_button)

                        Toast.makeText(this, "Class saved!" , Toast.LENGTH_SHORT).show()
                    }

                }
                else {
                    confirmDelete = true
                    deletebutton.text = "Are you sure?"
                    deletebutton.setBackgroundColor(getColor(R.color.red))
                    cancelButton.visibility = View.VISIBLE
                }
            }
            else {
                deleteFromDB()
                var intent = Intent(this , MainActivity::class.java)
                intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
                startActivity(intent)
                finish()
            }
        }

        cancelButton.setOnClickListener {
            deletebutton.background = getDrawable(R.drawable.delete_button)
            deletebutton.text = "Delete"
            confirmDelete = false
            cancelButton.visibility = View.INVISIBLE
        }

        backButton.setOnClickListener {
            finish()
        }

        editButton.setOnClickListener {
            if (isEdit != true) {
                editButton.text = "Cancel"
                deletebutton.setBackgroundColor(Color.parseColor("#00C853"))
                deletebutton.setText("Save")
                isEdit = true

                setFieldState(isEdit)
                changeBoxLook(isEdit)
            }

            else {
                editButton.text = "Edit"
                deletebutton.background = getDrawable(R.drawable.delete_button)
                isEdit = false

                setDefaultText()
                setFieldState(isEdit)
                changeBoxLook(isEdit)
            }
        }
    }

    fun deleteFromDB() {
        var result: ClassModel? = realm.where(ClassModel::class.java)
        .equalTo("id", id)
            .findFirst()

        realm.beginTransaction()
        result?.deleteFromRealm()
        realm.commitTransaction()
    }

    fun setFieldState(editState: Boolean) {
        if (editState == true) {
            courseNameTitle.isEnabled = true
            codeValue.isEnabled = true
            creditsValue.isEnabled = true
            timeValue.isEnabled = true
            locationValue.isEnabled = true
            daysValue.isEnabled = true
        }
        else {
            courseNameTitle.isEnabled = false
            codeValue.isEnabled = false
            creditsValue.isEnabled = false
            timeValue.isEnabled = false
            locationValue.isEnabled = false
            daysValue.isEnabled = false
        }
    }

    fun changeBoxLook(editState: Boolean){
        if (editState == true) {
            divider5.visibility = View.VISIBLE
            divider6.visibility = View.VISIBLE
            divider7.visibility = View.VISIBLE
            divider8.visibility = View.VISIBLE
            divider9.visibility = View.VISIBLE
            divider10.visibility = View.VISIBLE
        }
        else{
            divider5.visibility = View.INVISIBLE
            divider6.visibility = View.INVISIBLE
            divider7.visibility = View.INVISIBLE
            divider8.visibility = View.INVISIBLE
            divider9.visibility = View.INVISIBLE
            divider10.visibility = View.INVISIBLE
        }
    }

    fun setDefaultText(){
        courseNameTitle.setText(course.className)
        codeValue.setText(course.classCode)
        creditsValue.setText(course.hours.toString())
        timeValue.setText("TODO")
        locationValue.setText(course.deliveryMethod)
        daysValue.setText(course.days)
    }

}