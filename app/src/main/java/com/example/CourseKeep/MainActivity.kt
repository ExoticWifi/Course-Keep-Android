package com.example.myapplication

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.example.CourseKeep.activities.AddClassActivity
import com.example.CourseKeep.adapters.MainAdapter
import com.example.CourseKeep.models.ClassModel
import com.google.android.material.floatingactionbutton.FloatingActionButton
import io.realm.Realm
import io.realm.RealmResults
import java.util.ArrayList

class MainActivity : AppCompatActivity() {
    lateinit var addClassButton: FloatingActionButton
    lateinit var classRV: RecyclerView
    lateinit var realm: Realm
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        realm = Realm.getDefaultInstance()
        classRV = findViewById(R.id.courseList)
        addClassButton = findViewById(R.id.addClassButton)
        classRV.layoutManager = LinearLayoutManager(this)

        addClassButton.setOnClickListener {
            startActivity(Intent(this, AddClassActivity::class.java))
        }

        getAllClasses()

    }

    override fun onResume() {
        super.onResume()

        classRV.adapter?.notifyDataSetChanged();
    }

    fun getAllClasses(){
        var courseList: ArrayList<ClassModel>

        val results: RealmResults<ClassModel> = realm.where(ClassModel::class.java).findAll()
        classRV.adapter = MainAdapter(results)
        classRV.adapter!!.notifyDataSetChanged()
    }
}