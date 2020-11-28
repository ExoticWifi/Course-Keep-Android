package com.example.CourseKeep.viewHolders

import android.content.Intent
import android.view.View
import android.widget.TextView
import android.widget.Toast
import androidx.cardview.widget.CardView
import androidx.recyclerview.widget.RecyclerView
import com.example.CourseKeep.CourseInfoActivity
import com.example.CourseKeep.activities.AddClassActivity
import com.example.CourseKeep.models.ClassModel
import com.example.myapplication.MainActivity
import com.example.myapplication.R
import io.realm.Realm
import org.w3c.dom.Text
import java.lang.StringBuilder

class CustomViewHolder(var v: View , var classs: ClassModel): RecyclerView.ViewHolder(v) {
    val courseTitle = itemView.findViewById<TextView>(R.id.courseName)
    val courseCode = itemView.findViewById<TextView>(R.id.courseCode)
    val deliveryMethod = itemView.findViewById<TextView>(R.id.deliveryMethod)
    val coursedays = emptyArray<String>()
    lateinit var realm: Realm

    init {
        println(classs.mon)
        var message = StringBuilder()
        message.append("The days are: ")
        v.setOnClickListener{
            val intent = Intent(v.context, CourseInfoActivity::class.java)
            intent.putExtra("cLass", classs.id)
            v.context.startActivity(intent)
        }
    }
}