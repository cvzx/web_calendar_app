# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

users = User.create([
  { username: 'user1', password: '123' },
  { username: 'user2', password: '123' }
])

# users = User.all

Appointment.create([
  {
    user_id: users.first.id,
    title: 'first appointment',
    description: 'first appointment description',
    start_date: Time.zone.today.beginning_of_day + 4.hours,
    end_date: Time.zone.today.beginning_of_day + 7.hours
  },
  {
    user_id: users.first.id,
    title: 'second appointment',
    description: 'second appointment description',
    start_date: Time.zone.today.beginning_of_day + 8.hours,
    end_date: Time.zone.today.beginning_of_day + 12.hours
  },
  {
    user_id: users.first.id,
    title: 'third appointment',
    description: 'third appointment description',
    start_date: Time.zone.today.beginning_of_day + 18.hours,
    end_date: Time.zone.today.beginning_of_day + 22.hours
  },
  {
    user_id: users.first.id,
    title: 'fourth appointment',
    description: 'fourth appointment description',
    start_date: Time.zone.tomorrow.beginning_of_day + 12.hours,
    end_date: Time.zone.tomorrow.beginning_of_day + 19.hours
  },
  {
    user_id: users.first.id,
    title: 'fifth appointment',
    description: 'fifth appointment description',
    start_date: Time.zone.tomorrow.beginning_of_day + 20.hours,
    end_date: Time.zone.tomorrow.beginning_of_day + 22.hours
  },
  {
    user_id: users.first.id,
    title: 'sixth appointment',
    description: 'sixth appointment description',
    start_date: (Time.zone.today + 2.days).beginning_of_day + 18.hours,
    end_date: (Time.zone.today + 2.days).beginning_of_day + 21.hours
  },
  {
    user_id: users.second.id,
    title: 'first appointment',
    description: 'first appointment description',
    start_date: Time.zone.now.beginning_of_day + 8.hours,
    end_date: Time.zone.now.beginning_of_day + 21.hours
  },
  {
    user_id: users.second.id,
    title: 'second appointment',
    description: 'second appointment description',
    start_date: Time.zone.tomorrow.beginning_of_day + 6.hours,
    end_date: Time.zone.tomorrow.beginning_of_day + 18.hours
  },
  {
    user_id: users.second.id,
    title: 'third appointment',
    description: 'third appointment description',
    start_date: (Time.zone.today + 2.days).beginning_of_day + 7.hours,
    end_date: (Time.zone.today + 2.days).beginning_of_day + 19.hours
  },
  {
    user_id: users.second.id,
    title: 'fourth appointment',
    description: 'fourth appointment description',
    start_date: (Time.zone.today + 3.days).beginning_of_day + 8.hours,
    end_date: (Time.zone.today + 3.days).beginning_of_day + 20.hours
  }
])
