import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:mysavingapp/common/utils/mysaving_images.dart';
import 'package:mysavingapp/config/bloc/app_bloc.dart';
import 'package:mysavingapp/pages/dashboard/helpers/charts/dashboard_analitycs.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  static Page<void> page() => const MaterialPage<void>(child: Dashboard());
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  MySavingImages images = MySavingImages();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 10, top: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        SizedBox(
                            width: 50,
                            child: Image.asset(images.defaultProfilePicture)),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            children: [
                              Text('Dzień dobry'),
                              Text('Maciej'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.notifications))
                ],
              ),
            ),
            Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 150,
                  width: 180,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.redAccent),
                  child: Column(children: [
                    Expanded(
                        child: Column(
                      children: [
                        Text('Twoje oszczednosci'),
                        Gap(30),
                        Text('5,760.19 PLN'),
                      ],
                    )),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 30,
                            height: 20,
                            color: Colors.white,
                          )
                        ],
                      ),
                    )
                  ]),
                ),
                Gap(20),
                Container(
                  height: 150,
                  width: 180,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.redAccent),
                  child: Column(children: [
                    Expanded(
                        child: Column(
                      children: [
                        Text('Podsumowanie'),
                        Gap(5),
                        SizedBox(
                          width: 100,
                          child: Column(
                            children: [
                              Text(
                                'Saldo',
                              ),
                              Row(
                                children: [Icon(Icons.abc), Text('2000 PLN')],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: Column(
                            children: [
                              Text('Oszczędnosci'),
                              Row(
                                children: [
                                  Icon(Icons.account_balance_wallet),
                                  Text('2000 PLN')
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: Column(
                            children: [
                              Text('Wydatki'),
                              Row(
                                children: [
                                  Icon(Icons.access_alarm_outlined),
                                  Text('2000 PLN')
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    )),
                  ]),
                ),
              ],
            ),
            Gap(30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 44.0,
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xFF444FFF)),
                  child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent),
                      onPressed: () {},
                      icon: Icon(Icons.save),
                      label: const Text('Analitycs')),
                ),
                Gap(20),
                Container(
                  height: 44.0,
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xFF444FFF)),
                  child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent),
                      onPressed: () {},
                      icon: Icon(Icons.save),
                      label: const Text('Last Month')),
                ),
              ],
            ),
            Gap(20),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Text('My Analysis'),
                  ),
                  Container(
                    width: 80,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xFF444FFF)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('This week'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Gap(20),
            // DashboardAnalitycs(),
            ElevatedButton(
                onPressed: () {
                  context.read<AppBloc>().add(AppLogoutRequested());
                },
                child: Text('Wyloguj'))
          ],
        ),
      )),
    );
  }
}
