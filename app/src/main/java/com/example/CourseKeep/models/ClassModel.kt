package com.example.CourseKeep.models

import io.realm.RealmObject
import io.realm.annotations.PrimaryKey

open class ClassModel (@PrimaryKey var className: String? = null, var classCode: String? = null, var deliveryMethod: String? = null , var id: Int? = 0): RealmObject() {

}