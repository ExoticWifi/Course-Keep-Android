package com.example.CourseKeep

import android.app.Application
import io.realm.Realm
import io.realm.RealmConfiguration

class myApp: Application() {
    override fun onCreate() {
        super.onCreate()

        //initialize realm
        Realm.init(this)

        val configuration = RealmConfiguration.Builder()
            .name("ClassList.db")
            .deleteRealmIfMigrationNeeded()
            .schemaVersion(0)
            .build()

        Realm.setDefaultConfiguration(configuration)
    }
}