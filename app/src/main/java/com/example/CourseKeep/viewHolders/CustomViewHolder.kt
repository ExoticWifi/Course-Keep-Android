package com.example.CourseKeep.viewHolders

import android.view.View
import android.widget.TextView
import androidx.cardview.widget.CardView
import androidx.recyclerview.widget.RecyclerView
import com.example.CourseKeep.models.ClassModel
import com.example.myapplication.R
import org.w3c.dom.Text

class CustomViewHolder(var v: View , var classs: ClassModel? = null): RecyclerView.ViewHolder(v) {
    val courseTitle = itemView.findViewById<TextView>(R.id.courseName)
    val courseCode = itemView.findViewById<TextView>(R.id.courseCode)
    val deliveryMethod = itemView.findViewById<TextView>(R.id.deliveryMethod)
}