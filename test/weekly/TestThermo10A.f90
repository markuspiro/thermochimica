
program TestThermo10

    !-------------------------------------------------------------------------------------------------------------
    !
    ! DISCLAIMER
    ! ==========
    !
    ! All of the programming herein is original unless otherwise specified.  Details of contributions to the
    ! programming are given below.
    !
    !
    ! Revisions:
    ! ==========
    !
    !    Date          Programmer        Description of change
    !    ----          ----------        ---------------------
    !    02/07/2012    M.H.A. Piro       Original code
    !
    !
    ! Purpose:
    ! ========
    !
    ! The purpose of this unit test is to ensure that Thermochimica converges for a system representing slightly
    ! oxidized UO2+/-x nuclear fuel.  The data-file is representative of the full U-O system, which includes a
    ! regular solution model of the fluorite UO2+/-x phase (Thompson et al).  The thermochemical activity of O2(g)
    ! is checked in addition to INFOThermo.  This particular unit test is taken from the Verification Manual.
    !
    !
    ! References:
    ! ===========
    !
    !   W.T. Thompson, B.J. Lewis, E.C. Corcoran, M.H. Kaye, S.J. White, F. Akbari, Z. He, R. Verrall,
    !   J.D. Higgs, D.M. Thompson, T.M. Besmann, S.C. Vogel, "Thermodynamic Treatment of Uranium Dioxide Based
    !   Nuclear Fuel," International Journal of Materials Research, 98 (2007) 1004-1011.
    !
    !-------------------------------------------------------------------------------------------------------------


    USE ModuleThermoIO
    USE ModuleThermo

    implicit none


    ! Initialize variables:
    dTemperature            = 1273.15D0
    dPressure               = 1D0
    dElementMass(8)         = 2.125D0    ! O
    dElementMass(92)        = 1D0       ! U
    cInputUnitTemperature   = 'K'
    cInputUnitPressure      = 'atm'
    cInputUnitMass          = 'moles'
    cThermoFileName         = '../data/Example4.dat'

    ! Parse the ChemSage data-file:
    call ParseCSDataFile(cThermoFileName)

    ! Call Thermochimica:
    call Thermochimica

    ! Check results (error code & oxygen partial pressure):
    if (INFOThermo == 0) then
        print *, 'TestThermo10: PASS'
    else
        ! The unit test failed.
        print *, 'TestThermo10: FAIL <---'
    end if

    iPrintResultsMode = 2

    call PrintResults

    ! Reset Thermochimica:
    call ResetThermo

end program TestThermo10
